Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from serv2.oss.ntt.co.jp ([222.151.198.100])
 by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S5SAJ-0003Cu-5U
 for kexec@lists.infradead.org; Thu, 08 Mar 2012 01:29:13 +0000
Message-ID: <4F580B5F.5070304@oss.ntt.co.jp>
Date: Thu, 08 Mar 2012 10:29:03 +0900
From: =?ISO-8859-1?Q?Fernando_Luis_V=E1zquez_Cao?=
 <fernando@oss.ntt.co.jp>
MIME-Version: 1.0
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in
 crash path
References: <20120216215603.GH9751@redhat.com>
 <m1y5s2ku36.fsf@fess.ebiederm.org> <m1fwe9bpk2.fsf@fess.ebiederm.org>
 <20120217195430.GO9751@redhat.com> <m1y5s07rn3.fsf@fess.ebiederm.org>
 <20120220151419.GU9751@redhat.com> <m1obss39a4.fsf@fess.ebiederm.org>
 <20120221135934.GF26998@redhat.com> <m1ipip6xe8.fsf@fess.ebiederm.org>
 <4F573E1C.2060909@oss.ntt.co.jp> <20120307155018.GA13430@redhat.com>
 <CAE9FiQXLMzVLH7MW2OXFCpBU+5RRN-EnshGYhkj_3sO36c1Mkg@mail.gmail.com>
In-Reply-To: <CAE9FiQXLMzVLH7MW2OXFCpBU+5RRN-EnshGYhkj_3sO36c1Mkg@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Don Zickus <dzickus@redhat.com>, akpm@linux-foundation.org, linux-tip-commits@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>

On 03/08/2012 03:27 AM, Yinghai Lu wrote:

> 2012/3/7 Vivek Goyal<vgoyal@redhat.com>:
>> On Wed, Mar 07, 2012 at 07:53:16PM +0900, Fernando Luis V=E1zquez Cao wr=
ote:
>>> We run into the same NMI problems and wrote some patches that tackle
>>> the kernel boot side of things. They have been extensively tested using
>>> qemu-kvm and things seem to be working as expected (after receiving an
>>> early NMI the kernel continues without problem; after the iret there is=
 no
>>> stack corruption or register corruption).
>> What happens if NMI happens while we are still in purgatory code?
The system triple faults. As Eric said we need to fix both the reboot path
to kdump and kdump kernel's boot code. The two patches I sent address the
later. I sent these first because I had time to test them properly, fix a
real issue and can be applied independently.



> yes, you are right. that is too late to set that in arch/x86/kernel/head6=
4.c
Of course, the reboot path needs to be fixed too. Now that I solved some
problems I was having with my qemu-kvm test environment (NMIs injected
through the qemu monitor only get devivered to the BSP, etc), I will make
sure that the code I wrote for it works as expected.

In the meantime, I would appreciate it if you could review/ack yesterday's
patches.

Thanks,
Fernando


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
