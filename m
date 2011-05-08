Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-bw0-f49.google.com ([209.85.214.49])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QJ5xF-0004n7-Cx
	for kexec@lists.infradead.org; Sun, 08 May 2011 15:31:34 +0000
Received: by bwz1 with SMTP id 1so4578367bwz.36
	for <kexec@lists.infradead.org>; Sun, 08 May 2011 08:31:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110507075500.GB29941@regiomontanus.bwalle.de>
References: <BANLkTi=Jt=Q9Q9kM4ogtpW0PN7k=WSLtTQ@mail.gmail.com>
	<20110507075500.GB29941@regiomontanus.bwalle.de>
Date: Sun, 8 May 2011 23:31:30 +0800
Message-ID: <BANLkTikgb4f-OTj1zdw9OkOWb-OZpwJS7g@mail.gmail.com>
Subject: Re: kdump without the kexec
From: Lei Wen <adrian.wenl@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Bernhard Walle <bernhard@bwalle.de>
Cc: kexec@lists.infradead.org

Hi Bernhard,

On Sat, May 7, 2011 at 3:55 PM, Bernhard Walle <bernhard@bwalle.de> wrote:
> * Lei Wen <adrian.wenl@gmail.com> [2011-05-06 16:33]:
>>
>> Is there any existed solution that could make the kdump without the kexec?
>> For some kind of system hang, always hardware bug, or software deadlock, which
>> could not trigger the kernel oops, so that the first kernel cannot
>> load the second kernel
>> with kexec tool. The only way here is to directly press the reset key.
>>
>> We could be assure that the ddr memory would not be corrupted by this
>> way of reset
>> (for we don't shutdown the ddr power during the reset). So my question
>> is that whether
>> we could take use of bootloader, like the u-boot, to pretend we are
>> loading the second kernel
>> after the reset behavior and then perform the kdump process?
>
> Did you try sysrq-c? Which platform? Most of them have the concept of a
> NMI that also can trigger kdump.
>
>
For some case, the sysrq-c also cannot help, as the cpu is not
responding anymore for some
hw bug. I am running on arm board, there is no NMI concept on it...
So the only help is to put the hw reset and wish the bootloader do the
task which is expected
done by the kexec...

Best regards,
Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
