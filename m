Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V3rTT-0001Gh-M1
 for kexec@lists.infradead.org; Mon, 29 Jul 2013 17:43:12 +0000
Date: Mon, 29 Jul 2013 10:42:50 -0700
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kexec/kdump implementation for Xen PV domU
Message-ID: <20130729174250.GB19271@kroah.com>
References: <20130729171543.GA2600@router-fw-old.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130729171543.GA2600@router-fw-old.local.net-space.pl>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Daniel Kiper <dkiper@net-space.pl>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, daniel.kiper@oracle.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, abyde@acunu.com, tim@acunu.com, ebiederm@xmission.com, brandon@ifup.org, grzegorz.milos@gmail.com, virtualization@lists.linux-foundation.org

On Mon, Jul 29, 2013 at 07:15:43PM +0200, Daniel Kiper wrote:
> Hi all,
> 
> Here I am sending as attachments patches enabling kexec/kdump
> support in Xen PV domU. Only x84_64 architecture is supported.
> There is no support for i386 but some code could be easily reused.
> Here is a description of patches:
>   - kexec-tools-2.0.3_20120522.patch: patch for kexec-tools
>     which cleanly applies to version 2.0.3,
>   - kexec-kernel-only_20120522.patch: main kexec/kdump kernel patch;
>     it was prepared for quite old custom version of Xen Linux Kernel 2.6.18;
>     it should apply to publicly available Xen Linux Kernel 2.6.18 after
>     doing some needed changes,
>   - kexec-kernel-only_20121119.patch: patch fixes initial boot
>     structures overwrites on machines with memory larger than 1 GiB;
>     this is partial solution,
>   - kexec-kernel-only_20121203.patch: this patch fixes timer
>     issue on Amazon EC2 machines.

<snip>

> All code is GPL 2 licensed (http://www.gnu.org/licenses/gpl-2.0.html).
> Feel free to base your development on this patchset but please do not
> remove any copyrights. Addtionally, I am happy to help anybody who is
> interested in work on this stuff.
> 
> Big thank you for Acunu Ltd. (http://www.acunu.com/) for
> sponsoring initial work on Xen PV domU.

Thanks so much for releasing this code, it's much appreciated.  I'll
take this and work to get it merged upstream as much as possible.

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
