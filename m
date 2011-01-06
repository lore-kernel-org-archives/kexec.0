Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-iw0-f177.google.com ([209.85.214.177])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Pav6n-0001QY-Fq
	for kexec@lists.infradead.org; Thu, 06 Jan 2011 19:02:51 +0000
Received: by iwn38 with SMTP id 38so17604150iwn.36
	for <kexec@lists.infradead.org>; Thu, 06 Jan 2011 11:02:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <m1bp3uifln.fsf@fess.ebiederm.org>
References: <1294302325-22593-1-git-send-email-amwang@redhat.com>
	<m1bp3uifln.fsf@fess.ebiederm.org>
Date: Thu, 6 Jan 2011 14:02:47 -0500
Message-ID: <AANLkTinLhAuSny735kofonAkaqwJvjjDHMUed_r03rVc@mail.gmail.com>
Subject: Re: [Patch] kexec_load: check CAP_SYS_MODULE
From: Eric Paris <eparis@parisplace.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Amerigo Wang <amwang@redhat.com>, eparis@redhat.com, linux-kernel@vger.kernel.org

On Thu, Jan 6, 2011 at 3:47 AM, Eric W. Biederman <ebiederm@xmission.com> w=
rote:
> Amerigo Wang <amwang@redhat.com> writes:
>
>> Eric pointed out that kexec_load() actually allows you to
>> run any code you want in ring0, this is more like CAP_SYS_MODULE.
>
> Let me get this straight you want to make the permission checks
> less stringent by allowing either CAP_SYS_MODULE or CAP_SYS_BOOT?

Nope, read my patch again.  It actually requires BOTH of them.

> CAP_SYS_BOOT is the correct capability. =A0Sure you can run any
> code but only after rebooting. =A0I don't see how this differs
> from any other reboot scenario.

The difference is that after a reboot the bootloader and the system
control what code is run.  kexec_load() immediately runs the new
kernel which is not controlled by the bootloader or by the system.
Imagine a situation where the bootloader and the /boot directory are
RO (enforced by hardware).   kexec_load() would let you run any kernel
code you want on the box whereas reboot would not.

>> Reported-by: Eric Paris <eparis@redhat.com>
>> Signed-off-by: WANG Cong <amwang@redhat.com>
>>
>> ---
>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>> index b55045b..c30d613 100644
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -945,7 +945,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, un=
signed long, nr_segments,
>> =A0 =A0 =A0 int result;
>>
>> =A0 =A0 =A0 /* We only trust the superuser with rebooting the system. */
>> - =A0 =A0 if (!capable(CAP_SYS_BOOT))
>> + =A0 =A0 if (!capable(CAP_SYS_BOOT) || !capable(CAP_SYS_MODULE))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
>>
>> =A0 =A0 =A0 /*

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
