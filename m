Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp2.provo.novell.com ([137.65.250.81])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eedds-0006Av-8c
 for kexec@lists.infradead.org; Thu, 25 Jan 2018 09:16:21 +0000
Date: Thu, 25 Jan 2018 10:15:59 +0100
From: Petr Tesarik <ptesarik@suse.com>
Subject: Re: [makedumpfile PATCH 0/2] Fix calculations in exclude_segment()
Message-ID: <20180125101559.20f42a5c@ezekiel.suse.cz>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701F37744@BPXM01GP.gisp.nec.co.jp>
References: <cover.1516354241.git.ptesarik@suse.com>
 <20180123062813.GB1968@localhost.localdomain>
 <0910DD04CBD6DE4193FCF86B9C00BE9701F37744@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, 23 Jan 2018 08:49:48 +0000
Atsushi Kumagai <ats-kumagai@wm.jp.nec.com> wrote:

> >On 01/19/18 at 12:45pm, Petr Tesarik wrote:  
> >> I have observed that makedumpfile --mem-usage shows bogus numbers
> >> on a kaslr-enabled kernel. This boils down to incorrect calculations
> >> in exclude_segment(). Consequently, data beyond a split LOAD segment
> >> are read from the wrong file offset.
> >>
> >> Petr Tesarik (2):
> >>   Fix off-by-one errors in exclude_segment()
> >>   Fix physical-to-virtual conversion in exclude_segment()
> >>
> >>  elf_info.c | 22 +++++++++++-----------
> >>  1 file changed, 11 insertions(+), 11 deletions(-)  
> >
> >Ack the series, thanks!  
> 
> Thanks guys, I'll merge them into v1.6.3.

Glad to help. And thanks for merging into 'devel'!

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
