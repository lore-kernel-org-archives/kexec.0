Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eKVvx-0000cJ-Lg
 for kexec@lists.infradead.org; Thu, 30 Nov 2017 20:59:51 +0000
Date: Thu, 30 Nov 2017 21:59:15 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v1] kexec-tools: Perform run-time linking of libxenctrl.so
Message-ID: <20171130205915.GB16962@olila.local.net-space.pl>
References: <1511973916-3915-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1511973916-3915-1-git-send-email-eric.devolder@oracle.com>
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
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com

On Wed, Nov 29, 2017 at 10:45:16AM -0600, Eric DeVolder wrote:
> When kexec is utilized in a Xen environment, it has an explicit
> run-time dependency on libxenctrl.so. This dependency occurs
> during the configure stage and when building kexec-tools.
>
> When kexec is utilized in a non-Xen environment (either bare
> metal or KVM), the configure and build of kexec-tools omits
> any reference to libxenctrl.so.
>
> Thus today it is not currently possible to configure and build
> a *single* kexec that will work in *both* Xen and non-Xen
> environments, unless the libxenctrl.so is *always* present.

[...]

I will take a look at this next week.

Thanks,

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
