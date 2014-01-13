Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W2d7h-00087Z-97
 for kexec@lists.infradead.org; Mon, 13 Jan 2014 08:43:53 +0000
Date: Mon, 13 Jan 2014 17:43:30 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] vmcore-dmesg: struct_val_u64() not casting u64 to u32
Message-ID: <20140113084329.GB29308@verge.net.au>
References: <1389029854-2052-1-git-send-email-chaowang@redhat.com>
 <20140106191447.GA19883@redhat.com>
 <20140113052944.GG9622@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140113052944.GG9622@dhcp-17-89.nay.redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On Mon, Jan 13, 2014 at 01:29:44PM +0800, WANG Chao wrote:
> On 01/06/14 at 02:14pm, Vivek Goyal wrote:
> > On Tue, Jan 07, 2014 at 01:37:34AM +0800, WANG Chao wrote:
> > > It seems gcc doesn't check return type from inline function.
> > > struct_val_u64() should return u64 otherwise upper 32bit is lost.
> > > 
> > > Signed-off-by: WANG Chao <chaowang@redhat.com>
> > 
> > Acked-by: Vivek Goyal <vgoyal@redhat.com>
> > 
> > Vivek
> 
> Hi, Simon
> 
> Could you please pick up this one?

Done, thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
