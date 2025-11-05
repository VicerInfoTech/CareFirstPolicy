CFP.Enum = new function () {

    this.Role = {
        SuperAdmin: "Super Admin",
        Patient: "Patient",
        Administrator: "Administrator",
        Sample_Collector_PSC: "Sample Collector (PSC)",
        Lab_Assistant: "Lab Scientist",
        Sample_Collector_InHome: "Sample Collector (In-Home)",
        Fulfillment_Manager: "Fulfillment Manager",
    }

    this.TestStatus = {
        New : 1,
        Order_Confirmed:2, 
        Appointment_Booked:3,
        Appointment_ReScheduled:4,
        CheckedIn:5,
        Fulfillment_Complete : 6,
        Sample_Shipped_To_Patient : 7,
        Sample_Received_At_Patient : 8,
        Kit_Registred:9,
        Sample_Collected : 10,
        Sample_Shipped_To_Lab : 11,
        Sample_Received_At_Lab : 12,
        Re_Processing: 13,
        In_Process : 14,
        Complete : 15,
    }

    this.AppointmentStatus =
    {
        Pending: 1,
        Booked: 2,
        ReSchedule: 3,
        Cancel: 4,
        Completed: 5,
    }

    this.TestType = {
        AtHome: 1,
        InPerson: 2,
        WalkIn: 3,
        DCS: 4,
    }

    this.OrderListType = {
        All: 1,
        Fulfillment: 2,
        Shipment: 3,
        AppointmentBooking: 4,
        SampleCollection: 5,
        LabProcessing: 6,
        Completed: 7,
        CheckIn: 8,
    }

}