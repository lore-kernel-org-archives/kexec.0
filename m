Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJxlm-0001rO-KB
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 03:40:39 +0000
Date: Wed, 11 Sep 2013 20:40:23 -0700
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 00/16] [RFC PATCH] Signed kexec support
Message-ID: <20130912034023.GA10877@kroah.com>
References: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: matthew.garrett@nebula.com, d.kasatkin@samsung.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, zohar@linux.vnet.ibm.com

On Tue, Sep 10, 2013 at 05:44:15PM -0400, Vivek Goyal wrote:
> Hi,
> 
> Matthew has been posting patches to lock down kernel either due to
> secureboot requirements or because of signed modules with signing
> enforced. In kernel lock down mode, kexec will be disabled and that
> means kdump will not work either.
> 
> These patches sign /sbin/kexec and kernel verifies the signature
> and allows loading a kernel if signature verification is successful.
> IOW, trust is extended to validly signed user space.
> 
> Currently it works only for statically linked applications.

That's a really big restriction, pretty much making it not workable for
distros at the moment to use.

Any chance to change this in the future?  Or just rely on the existing
"signed binaries" functionality we have in the kernel today for the
kexec binary as well?  Wouldn't that be simpler?

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
