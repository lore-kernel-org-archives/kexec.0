Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fYOF4-0000Uj-4n
 for kexec@lists.infradead.org; Thu, 28 Jun 2018 04:09:11 +0000
Date: Thu, 28 Jun 2018 12:08:32 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: kdump on VFAT?
Message-ID: <20180628040832.GA4522@dhcp-128-65.nay.redhat.com>
References: <CAJCQCtQEom-_J9Gji-WRgj3V_2zjUWXxUhPkc+jCj+N2KP3rJw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJCQCtQEom-_J9Gji-WRgj3V_2zjUWXxUhPkc+jCj+N2KP3rJw@mail.gmail.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Chris Murphy <lists@colorremedies.com>
Cc: kexec@lists.infradead.org

Chris, if this is specific to Fedora, there is another list for the
topic:kexec@lists.fedoraproject.org

On 06/27/18 at 09:17am, Chris Murphy wrote:
> Hi,
> 
> Buried in this Fedora thread on the BootLoaderSpec, is the discussion on the
> technical merit (or not) of using VFAT for /boot which is currently
> where kdump drops the vmcore dumpfiles. So I'm wondering if
> there are any developer concerns about dumps going to VFAT and also if
> a viable work around is putting crash dumps in /var instead?

Fedora kdump drop initramfs in /boot, but the vmcore be saved in
/var/crash by default

> 
> For reference, BootLoaderSpec in effect requires VFAT for $BOOT which
> would contain bootloader configuration, kernel, initramfs, and would
> be mounted at /boot

One can configure kdump to save vmcore in /boot,  but if using VFAT I
believe there is a 2G max file size limitation that may be not enough for
big memory machine.

> 
> Fedora thread to make BootLoaderSpec default in Fedora 29 (note that
> really this feature only implements BootLoaderSpec file format for
> bootloader configuration; not the full spec that includes the VFAT
> requirement - that's still under discussion).
> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/message/CTKJBECHWEVF5IN6FO5TV7SIYWIMKYRT/
> 
> 
> BootLoaderSpec
> https://www.freedesktop.org/wiki/Specifications/BootLoaderSpec/
> https://github.com/systemd/systemd/blob/master/doc/BOOT_LOADER_SPECIFICATION.md

Thanks for sharing. Interesting idea, hmm, it belongs to systemd..

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
