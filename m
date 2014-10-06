Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1412623718.32313.60.camel@smoke>
Subject: Re: [PATCH 1/5] kexec: Fix make headers_check
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 06 Oct 2014 12:28:38 -0700
In-Reply-To: <1412619708.14236.2.camel@x220>
References: <cover.1408731991.git.geoff@infradead.org>
 <115373b6ac68ee7a305975896e1c4971e8e51d4c.1408731991.git.geoff@infradead.org>
 <20140825172234.GD14379@redhat.com> <1409402838.21896.99.camel@x220>
 <1412604734.4054.72.camel@x220> <1412616877.32313.55.camel@smoke>
 <1412619708.14236.2.camel@x220>
Mime-Version: 1.0
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
To: Paul Bolle <pebolle@tiscali.nl>
Cc: maximilian attems <max@stro.at>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>

On Mon, 2014-10-06 at 20:21 +0200, Paul Bolle wrote:
> On Mon, 2014-10-06 at 10:34 -0700, Geoff Levand wrote:
> > On Mon, 2014-10-06 at 16:12 +0200, Paul Bolle wrote:
> > > It seems not much happened after I added my Acked-by. I assume you still
> > > want to get this merged. Is that correct?
> > 
> > Yes, I think we concluded there are no real users of this kexec_load()
> > ptototype, and so it can be removed.
> 
> What would be the quickest way to get this finally resolved? Who's in
> charge of this stuff? Would resending your patch, with my Ack added,
> speed up things? The vain side of my personality does think it would
> help.

I'll prepare a V2 set of the this series with the various acks and ask
Andrew to merge it.

-Geoff



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
