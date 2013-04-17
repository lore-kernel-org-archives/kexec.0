Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USSoF-0005G8-5R
 for kexec@lists.infradead.org; Wed, 17 Apr 2013 13:54:03 +0000
Message-ID: <516EA95D.8010200@citrix.com>
Date: Wed, 17 Apr 2013 14:53:33 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] kexec/xen: directly load images images into Xen
References: <1365448014-12119-1-git-send-email-david.vrabel@citrix.com>
 <1365448014-12119-6-git-send-email-david.vrabel@citrix.com>
 <20130409212036.GE31533@debian70-amd64.local.net-space.pl>
 <20130417125602.GC906@debian70-amd64.local.net-space.pl>
In-Reply-To: <20130417125602.GC906@debian70-amd64.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 17/04/13 13:56, Daniel Kiper wrote:
> On Tue, Apr 09, 2013 at 11:20:36PM +0200, Daniel Kiper wrote:
>>
>> arch = (kexec_flags & KEXEC_ARCH_MASK) >> 16;
> 
> What is wrong with this line?
> Why did not you applied it?

I haven't reposted the kexec-tools patches so it's not clear what you
are expecting this to be applied to.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
