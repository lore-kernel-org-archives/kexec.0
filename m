Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f5pND-0005Fu-1i
 for kexec@lists.infradead.org; Tue, 10 Apr 2018 09:15:39 +0000
Date: Tue, 10 Apr 2018 11:15:16 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix a segmentation fault when trying to run "kexec -p"
Message-ID: <20180410091516.aymqdq7jy6u55c6j@verge.net.au>
References: <20180405133926.14cc92ef@ezekiel.suse.cz>
 <2f760cac-5005-626b-1f4f-ca9436427940@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2f760cac-5005-626b-1f4f-ca9436427940@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, Michal Suchanek <msuchanek@suse.de>, Petr Tesarik <ptesarik@suse.cz>

On Mon, Apr 09, 2018 at 02:14:09PM +0530, Bhupesh Sharma wrote:
> On 04/05/2018 05:09 PM, Petr Tesarik wrote:
> > Do not fall through to "--mem-min" when "-p" option is parsed. The
> > break statement was apparently removed by mistake...
> > 
> > Fixes: cb434cbe6f401037e448276bb12056d1fdc3dbfc
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > ---
> >   kexec/kexec.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/kexec/kexec.c b/kexec/kexec.c
> > index 612c1c2..313d9fe 100644
> > --- a/kexec/kexec.c
> > +++ b/kexec/kexec.c
> > @@ -1349,6 +1349,7 @@ int main(int argc, char *argv[])
> >   			do_sync = 0;
> >   			kexec_file_flags |= KEXEC_FILE_ON_CRASH;
> >   			kexec_flags = KEXEC_ON_CRASH;
> > +			break;
> >   		case OPT_MEM_MIN:
> >   			mem_min = strtoul(optarg, &endptr, 0);
> >   			if (*endptr) {
> > 
> 
> 'kexec -p' is currently broken (segfaults) upstream. I tested this fix on my
> arm64 board, so:
> 
> Tested-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks, applied with the fixes tag updated to:

Fixes: cb434cbe6f40 ("kexec: Do not special-case the -s option")

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
