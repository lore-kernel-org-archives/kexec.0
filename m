Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]
	helo=outbound3-sin-R.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HlR7g-0005Jq-Ou
	for kexec@lists.infradead.org; Tue, 08 May 2007 10:57:07 -0400
Message-ID: <46408FB6.8070705@am.sony.com>
Date: Tue, 08 May 2007 07:56:54 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: [patch 3/5] kexec add strict-prototypes
References: <20070507235727.631477448@am.sony.com>>
	<463FBE30.8080500@am.sony.com> <20070508023811.GA8170@verge.net.au>
In-Reply-To: <20070508023811.GA8170@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Simon Horman wrote:
> On Mon, May 07, 2007 at 05:02:56PM -0700, Geoff Levand wrote:
>> Add -Wstrict-prototypes to EXTRA_CFLAGS and fix the powerpc compiler warnings.
>> 
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> Hi Geoff,
> 
> I'm all for fixing up this kind of thing, but I'm not sure that
> hardcoding it into -Wstrict-prototypes is the right way to go.
> People who want -Wstrict-prototypes can just add it to CFLAGS
> in the environment and fix problems from there. Then again, it is
> kind of nice to get rid of all this crap :-)
> 
> Could you split the configure.ac patch and the fixes into two separate
> patches so that they can be considered separtely?

Sure.  New patches will follow.

> 
> The change to sort_base_ranges() seems like a lot of diff for very
> little change. Is it whitespace fixes. If so could you put that in a
> separate patch?
> 

It is just a move.  sort_base_ranges() was defined after
it was used.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
