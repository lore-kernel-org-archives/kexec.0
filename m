Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlOdk-0005c4-9m
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 19:49:44 +0000
Date: Tue, 26 Nov 2013 20:49:10 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH] kexec/xen: Fix typo in __i386__ preprocessor identifier
Message-ID: <20131126194910.GD25648@olila.local.net-space.pl>
References: <1385487757-18378-1-git-send-email-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385487757-18378-1-git-send-email-andrew.cooper3@citrix.com>
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
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, Xen-devel <xen-devel@lists.xen.org>

On Tue, Nov 26, 2013 at 05:42:37PM +0000, Andrew Cooper wrote:
> This typo was introduced in c/s c0b4a3f95dd80256cc6d7084436235e69b4933fb
>
> It prevents a 32bit build of kexec from loading a 32bit crash image.
>
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> CC: David Vrabel <david.vrabel@citrix.com>
> CC: Daniel Kiper <daniel.kiper@oracle.com>
> CC: Simon Horman <horms@verge.net.au>
> CC: kexec@lists.infradead.org

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
