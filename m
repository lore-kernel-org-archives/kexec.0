Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from an-out-0708.google.com ([209.85.132.248])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KM6po-0007nk-TD
	for kexec@lists.infradead.org; Thu, 24 Jul 2008 19:50:45 +0000
Received: by an-out-0708.google.com with SMTP id c24so611848ana.99
	for <kexec@lists.infradead.org>; Thu, 24 Jul 2008 12:50:43 -0700 (PDT)
Message-ID: <4888DCEE.8090807@codemonkey.ws>
Date: Thu, 24 Jul 2008 14:50:06 -0500
From: Anthony Liguori <anthony@codemonkey.ws>
MIME-Version: 1.0
Subject: Re: kexec/kdump of a kvm guest?
References: <170fa0d20806261158me6f81d0p2ea4fa6b7e694a5a@mail.gmail.com>	
	<486F58EC.6020408@qumranet.com>	
	<170fa0d20807231713t19b5bd5bt5f418f509040b7aa@mail.gmail.com>	
	<D8D3E355-6D19-403B-8F61-FC15EA78851F@suse.de>	
	<170fa0d20807240449n3e52c002qdb9c2626a192b0f1@mail.gmail.com>	
	<20080724131552.GA22243@redhat.com>
	<170fa0d20807241203h7065b643k7df1187ef7e76f87@mail.gmail.com>
In-Reply-To: <170fa0d20807241203h7065b643k7df1187ef7e76f87@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mike Snitzer <snitzer@gmail.com>
Cc: kvm@vger.kernel.org, libvir-list@redhat.com, kexec@lists.infradead.org, Alexander Graf <agraf@suse.de>, Avi Kivity <avi@qumranet.com>, Vivek Goyal <vgoyal@redhat.com>

Mike Snitzer wrote:
> On Thu, Jul 24, 2008 at 9:15 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
>   
>> On Thu, Jul 24, 2008 at 07:49:59AM -0400, Mike Snitzer wrote:
>>     
>>> On Thu, Jul 24, 2008 at 4:39 AM, Alexander Graf <agraf@suse.de> wrote:
>>>       
> I can do further research but welcome others' insight: do others have
> advice on how best to collect a crashed kvm guest's core?
>   

I don't know what you do in libvirt, but you can start a gdbstub in 
QEMU, connect with gdb, and then have gdb dump out a core.

Regards,

Anthony Liguori

>> It will be interesting to look at your results with 2.6.25.x kernels with
>> kvm module inserted. Currently I can't think what can possibly be wrong.
>>     
>
> If the host's 2.6.25.4 kernel has both the kvm and kvm-intel modules
> loaded kexec/kdump does _not_ work (simply hangs the system).  If I
> only have the kvm module loaded kexec/kdump works as expected
> (likewise if no kvm modules are loaded at all).  So it would appear
> that kvm-intel and kexec are definitely mutually exclusive at the
> moment (at least on both 2.6.22.x and 2.6.25.x).
>
> Mike
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
