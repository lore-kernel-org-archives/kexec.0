Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YjzX9-0004BZ-Jv
 for kexec@lists.infradead.org; Mon, 20 Apr 2015 00:25:56 +0000
Date: Mon, 20 Apr 2015 09:25:27 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH RFC 1/6] purgatory: Fix memcmp for src address increment
Message-ID: <20150420002527.GA17827@verge.net.au>
References: <cover.1429201849.git.panand@redhat.com>
 <6ac5de6bcd76b7a0790c3a403fa0c629c4a4eff8.1429201849.git.panand@redhat.com>
 <1429289744.5479.6.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1429289744.5479.6.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Pratyush Anand <panand@redhat.com>, kexec@lists.infradead.org

On Fri, Apr 17, 2015 at 09:55:44AM -0700, Geoff Levand wrote:
> On Thu, 2015-04-16 at 22:17 +0530, Pratyush Anand wrote:
> > src addresses are not being incremented, so only first byte is compared
> > instead of first len bytes.
> 
> So I guess this means we never really had proper error
> checking in purgatory...  Better merge this one.
> 
> Acked-by: Geoff Levand <geoff@infradead.org>

Hi Pratyush,

If you'd like me to take this plase repost it with Geoff's Ack
and without "RFC".

Thanks

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
