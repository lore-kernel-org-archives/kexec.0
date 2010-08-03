Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wy0-f177.google.com ([74.125.82.177])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OgCBE-0005wl-MW
	for kexec@lists.infradead.org; Tue, 03 Aug 2010 07:44:57 +0000
Received: by wyf19 with SMTP id 19so454566wyf.36
	for <kexec@lists.infradead.org>; Tue, 03 Aug 2010 00:44:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <m1zkx4w3hx.fsf@fess.ebiederm.org>
References: <AANLkTikuUi=i6Lk-ZpE65Gr0tWOeVnrnpWPe85T=J=Ph@mail.gmail.com> 
	<m1zkx4w3hx.fsf@fess.ebiederm.org>
From: Hui Zhu <teawater@gmail.com>
Date: Tue, 3 Aug 2010 15:44:35 +0800
Message-ID: <AANLkTi=-By6ZWjo9bW0s4MndFftHegROO7oa0jbpnCho@mail.gmail.com>
Subject: Re: [PATCH] kexec: set prstatus.pr_pid to cpu id when current->pid is
	0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: gdb@sourceware.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Simon Kagstrom <simon.kagstrom@netinsight.net>, WANG Cong <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Tue, Aug 3, 2010 at 15:37, Eric W. Biederman <ebiederm@xmission.com> wro=
te:
> Hui Zhu <teawater@gmail.com> writes:
>
>> Hi,
>>
>> I found that from gdb 7.1 to gdb-cvs-head cannot analyze the core file
>> that get from kdump.
>> What I got:
>> [New <main task>]
>> [New Thread 2719]
>> ../../src/gdb/thread.c:884: internal-error: switch_to_thread:
>> Assertion `inf !=3D NULL' failed.
>> A problem internal to GDB has been detected,
>> further debugging may prove unreliable.
>> Quit this debugging session? (y or n)
>> That is because:
>> =A0objdump -h ./vmcore
>>
>> ./vmcore: =A0 =A0 file format elf64-x86-64
>>
>> Sections:
>> Idx Name =A0 =A0 =A0 =A0 =A0Size =A0 =A0 =A0VMA =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 LMA =A0 =A0 =A0 =A0 =A0 =A0 =A0 File off =A0Algn
>> =A0 0 note0 =A0 =A0 =A0 =A0 00000a48 =A00000000000000000 =A0000000000000=
0000 =A000000238 =A02**0
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONTENTS, READONLY
>> =A0 1 .reg/0 =A0 =A0 =A0 =A0000000d8 =A00000000000000000 =A0000000000000=
0000 =A0000002bc =A02**2
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONTENTS
>> =A0 2 .reg =A0 =A0 =A0 =A0 =A0000000d8 =A00000000000000000 =A00000000000=
000000 =A0000002bc =A02**2
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONTENTS
>> =A0 3 .reg/2719 =A0 =A0 000000d8 =A00000000000000000 =A00000000000000000=
 =A000000420 =A02**2
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONTENTS
>> =A0 4 .reg/0 =A0 =A0 =A0 =A0000000d8 =A00000000000000000 =A0000000000000=
0000 =A000000584 =A02**2
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONTENTS
>> =A0 5 .reg/0 =A0 =A0 =A0 =A0000000d8 =A00000000000000000 =A0000000000000=
0000 =A0000006e8 =A02**2
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONTENTS
>> Each of reg/n is a cpu core note. =A0It will be a GDB thread. =A0n is the
>> prstatus.pr_pid that will be the thread lwpid. =A0Because the 3 threads
>> pid is same, so GDB get error.
>>
>> current->pid is 0 because this cpu is in idle. =A0So I add a check, set
>> prstatus.pr_pid to cpu id when current->pid is 0. =A0Then GDB work OK
>> with the core.
>
> That is a gdb limitation. =A0It looks to me like applying this patch will
> loose information, and give you no guarantee that prstatus.pr_pid will
> not equal 0.
>
> If you want to change something please do it in a post processing tool.
>
> Eric

Equal 0 is not a bug, the trouble is a lot of core's pid is same.

This is what gdb say:
/* Found an old thread with the same id.  It has to be dead,
       otherwise we wouldn't be adding a new thread with the same id.
       The OS is reusing this id --- delete it, and recreate a new
       one.  */

Hui

>
>
>> Thanks,
>> Hui
>>
>> Signed-off-by: Hui Zhu <teawater@gmail.com>
>> ---
>> =A0kernel/kexec.c | =A0 =A05 ++++-
>> =A01 file changed, 4 insertions(+), 1 deletion(-)
>>
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -1191,7 +1191,10 @@ void crash_save_cpu(struct pt_regs *regs
>> =A0 =A0 =A0 if (!buf)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 memset(&prstatus, 0, sizeof(prstatus));
>> - =A0 =A0 prstatus.pr_pid =3D current->pid;
>> + =A0 =A0 if (current->pid)
>> + =A0 =A0 =A0 =A0 =A0 =A0 prstatus.pr_pid =3D current->pid;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 prstatus.pr_pid =3D cpu;
>> =A0 =A0 =A0 elf_core_copy_kernel_regs(&prstatus.pr_reg, regs);
>> =A0 =A0 =A0 buf =3D append_elf_note(buf, KEXEC_CORE_NOTE_NAME, NT_PRSTAT=
US,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &prstatus, sizeo=
f(prstatus));
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
