Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L5y3C-0003Kv-Ih
	for kexec@lists.infradead.org; Fri, 28 Nov 2008 07:46:06 +0000
Date: Fri, 28 Nov 2008 08:46:02 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Parse 64 bit VMCOREINFO on 32 bit userland
Message-ID: <20081128084602.5acf4f0f@kopernikus.site>
In-Reply-To: <492F465D.6000609@mxs.nes.nec.co.jp>
References: <20081127160034.121f5911@hale.suse.de>
	<492F465D.6000609@mxs.nes.nec.co.jp>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

* Ken'ichi Ohmichi [2008-11-28 10:16]:
> 
> > Signed-off-by: Bernhard Walle <bwalle@suse.de>
> > 
> > ---
> >  makedumpfile.c |    7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -13,7 +13,6 @@
> >   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >   * GNU General Public License for more details.
> >   */
> > -#include <stdlib.h>
> 
> This is not related to this purpose, but this is reasonable and will
> be merged as the other patch ;-)

Yes ;)

> > @@ -2274,7 +2273,7 @@ read_vmcoreinfo_basic_info(void)
> >  unsigned long
> 
> unsigned long long ?

Right! Thanks for catching that. It worked in my case without that, but
probably because the symbol wasn't needed and only parsed with -c -D0.

I'll send a new patch later when I'm in the office ...


    Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
