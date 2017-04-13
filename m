Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cyc8C-0007GG-1w
 for kexec@lists.infradead.org; Thu, 13 Apr 2017 10:37:42 +0000
Received: by mail-wm0-x22f.google.com with SMTP id w64so108430163wma.0
 for <kexec@lists.infradead.org>; Thu, 13 Apr 2017 03:37:18 -0700 (PDT)
Subject: Re: Testing kexec/kdump on ls2085ardb (arm64)
References: <799fca3b-8d1c-c1d0-f3d7-e3b060f962fd@globallogic.com>
 <98f5b725-a4d4-c881-2b78-d369d6859acc@redhat.com>
 <3fa4df10-86f9-5a6d-d78f-48acd38f873c@globallogic.com>
 <b34ce5cb-82d3-a706-0a0b-98828ebb4417@redhat.com>
From: Denys Zagorui <denys.zagorui@globallogic.com>
Message-ID: <f4a70177-5d79-92e1-4a77-6832475d316b@globallogic.com>
Date: Thu, 13 Apr 2017 13:37:13 +0300
MIME-Version: 1.0
In-Reply-To: <b34ce5cb-82d3-a706-0a0b-98828ebb4417@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org



On 12.04.17 19:36, Pratyush Anand wrote:
> Hi Denys,
>
> On Wednesday 12 April 2017 08:05 PM, Denys Zagorui wrote:
>> Hello, Pratyush
>> Thanks for your reply.
>>
>> Could you describe how i can find out wich enable method used. One more
>> things, i made this tests on qemu, and it works. Logs attached.
>>
>
> From your board log (log_for_com ):
>
> PSCI: PSCI does not exist
>
>
> and then
>
> [   60.561877] Can't kexec: CPUs are stuck in the kernel.
>
> Above message is coming from machine_kexec_prepare() when
> cpus_are_stuck_in_kernel() returns true. See, its implementation. It
> will return true if number of possible cpus is > 1 and cpu_die() is not
> implemented.
>
> You can boot your first kernel with nr_cpus=1 in  kernel cmdline and
> then you should be able to kexec to the second kernel from there.
>
> However, it can not be a solution. You should update your firmware with
> psci implementation.
>
> For the time being you can have spin-table work aroudn like this [1],
> but please note that spin-table is discouraged upstream [2].
>
> [1]
> https://github.com/pratyushanand/linux/commit/a50e98635b7257c101f02f7ac488a4cb04187f6d
>
> [2] https://patchwork.kernel.org/patch/7873571/
>
>
> From your qemu log:
>
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv0.2 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: Trusted OS migration not required
>
>
> and so it works :-)
>
>
> ~Pratyush

Hi Pratyush

Both solutions works. Thanks. It's temporary solution,
i will contact with NXP support team

Best Regards,
Denys
-- 
Denys Zagorui
GlobalLogic
Kyiv, 03038, Protasov Business Park, N.Grinchenka, 2/1
M +38.067.317.30.93
www.globallogic.com

http://www.globallogic.com/email_disclaimer.txt

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
