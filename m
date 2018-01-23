Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eds4M-0002mJ-RY
 for kexec@lists.infradead.org; Tue, 23 Jan 2018 06:28:33 +0000
Date: Tue, 23 Jan 2018 14:28:13 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [makedumpfile PATCH 0/2] Fix calculations in exclude_segment()
Message-ID: <20180123062813.GB1968@localhost.localdomain>
References: <cover.1516354241.git.ptesarik@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1516354241.git.ptesarik@suse.com>
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
To: Petr Tesarik <ptesarik@suse.com>
Cc: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, kexec@lists.infradead.org

On 01/19/18 at 12:45pm, Petr Tesarik wrote:
> I have observed that makedumpfile --mem-usage shows bogus numbers
> on a kaslr-enabled kernel. This boils down to incorrect calculations
> in exclude_segment(). Consequently, data beyond a split LOAD segment
> are read from the wrong file offset.
> 
> Petr Tesarik (2):
>   Fix off-by-one errors in exclude_segment()
>   Fix physical-to-virtual conversion in exclude_segment()
> 
>  elf_info.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Ack the series, thanks!

> 
> -- 
> 2.13.6
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
