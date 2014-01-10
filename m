Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W1dEs-0002lh-Rp
 for kexec@lists.infradead.org; Fri, 10 Jan 2014 14:39:11 +0000
Date: Fri, 10 Jan 2014 09:38:46 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] acpi memory hotplug, add parameter to disable memory
 hotplug for kexec
Message-ID: <20140110143846.GA19115@redhat.com>
References: <1389220181-14474-1-git-send-email-prarit@redhat.com>
 <3476878.EqQiEtA2Ag@vostro.rjw.lan>
 <20140109150053.GD25897@redhat.com>
 <2117213.k9zFiTsMXU@vostro.rjw.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2117213.k9zFiTsMXU@vostro.rjw.lan>
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
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Prarit Bhargava <prarit@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Dave Young <dyoung@redhat.com>, Len Brown <lenb@kernel.org>

On Fri, Jan 10, 2014 at 02:31:31AM +0100, Rafael J. Wysocki wrote:

[..]
> > It is a fresh instance of kernel booting and it is initializing its data
> > structures fresh. It is *not* re-initializing ACPI in same kernel.
> 
> I know.  The problem is that the BIOS is generally not stateless and it
> remebers stuff.  In particular, there are a few handshakes done during the ACPI
> initialization and they cannot be repeated without resetting the BIOS to the
> initial state, which basically means a reboot.

Agreed that stateless BIOS in general would be a problem with kexec. We
already face that issue with UEFI where we can't call set virtual address
map again in second kernel and kexec did not work with UEFI for so many
years. Thanks to Dave, Borislav and Matt that it will soon be working and
we will be passing mappings to second kernel.

So even in case of ACPI, if there are things which can't be re-initiliazed
in second kernel, we will have to figure that out and selectively fix it
by passing that info to second kernel and not ask second kernel to
reinitialize it, instead of disabling ACPI completely.

> 
> That is kind of orthogonal to the problem at hand, though.

Agreed.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
