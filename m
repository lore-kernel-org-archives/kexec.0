Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WXSwf-00062z-JS
 for kexec@lists.infradead.org; Tue, 08 Apr 2014 10:08:00 +0000
Date: Tue, 8 Apr 2014 12:07:28 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v2 2/3] Generic handling of multi-page exclusions
Message-ID: <20140408120728.03224214@hananiah.suse.cz>
In-Reply-To: <20140408.171903.322808733.d.hatayama@jp.fujitsu.com>
References: <25702884512808755449395c1622f2aed7b3be00.1396632131.git.ptesarik@suse.cz>
 <20140408.104907.132144009.d.hatayama@jp.fujitsu.com>
 <20140408085436.51340ae2@hananiah.suse.cz>
 <20140408.171903.322808733.d.hatayama@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

On Tue, 08 Apr 2014 17:19:03 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> From: Petr Tesarik <ptesarik@suse.cz>
> Subject: Re: [PATCH v2 2/3] Generic handling of multi-page exclusions
> Date: Tue, 8 Apr 2014 08:54:36 +0200
> 
> > On Tue, 08 Apr 2014 10:49:07 +0900 (JST)
> > HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> >> 
> >> Also, it seems to me better to introduce a new type for this
> >> processing rather than extending existing code. struct mem_map_data is
> >> not specific for the excluding processing.
> > 
> > Kind of agreed. OTOH it will most likely be embedded in struct
> > mem_map_data anyway, because exactly one such object per mm is needed.
> > 
> > Petr T
> 
> I don't understand well. It seems to me a single object is enough. Is
> it possible to nr_pages cover multiple mm's?

In fact, I believe it may be sufficient, but the loop nesting is like
this (pseudo-code):

  for each cycle:
    for each mm:
       call __exclude_unnecessary_pages

I'm not 100% sure that the region cannot change back and forth between
two consecutive calls to __exclude_unnecessary_pages.

Thinking about it some more, this can be harmful only if there are
overlapping memory maps... Can it happen, or can I safely ignore this
possibility?

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
