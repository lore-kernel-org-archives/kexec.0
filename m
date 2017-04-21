Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 50-200-209-228-static.hfc.comcastbusiness.net ([50.200.209.228]
 helo=mail.litepoint.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d1hQg-0000fu-59
 for kexec@lists.infradead.org; Fri, 21 Apr 2017 22:53:31 +0000
From: Rudici Cazeao <rudici.cazeao@litepoint.com>
Subject: ARM lockup during Kexec operation
Date: Fri, 21 Apr 2017 22:53:09 +0000
Message-ID: <6aae0d1c65ae480fbfc73bbf2aa019c5@LPHQEX2013.litepoint.internal>
Content-Language: en-US
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Using kexec on a dual-core arm processor (arm7), the non-boot CPU (CPU1) ap=
pears to be locking up during kexec.

The SoC is mach-transcede=A0 =

The kernel version is 3.0.51-rt75

The issue is localized to=A0 linux-3.0.51/arch\arm/mach-transcede/hotplug.c.


=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cpu_enter_lowpower();
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 platform_do_lowpower(cpu, &spurious);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cpu_leave_lowpower().=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 / *=A0 bring this CPU back into the world of=
 cache=A0 coherency, and then restore interrupts=A0 */


static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
{
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (;;) {=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 / * there is no power-control hardware on=
 this platform, so all we can do is put the core into WFI; this is safe as =
the calling code will have already disabled interrupts */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wfe();
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 if (pen_release =3D=3D cpu) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 / * OK, proper wakeup, we'=
re done */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0}

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 (*spurious)++;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 / * Getting here, means that we have come out of WFI without having bee=
n woken up - Just note it happening - when we're woken, we can report its o=
ccurrence.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
}



When the issue occurs the non-boot CPU (ie CPU 1) is entering the platform_=
do_lowpower sequence where it should wait until pren_release is set to 1 by=
=A0 CPU1 =



Please note that=A0 This failure is random. It usually happens somewhere be=
tween 300 and 5000 kexec loops.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
