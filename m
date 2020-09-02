Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDVde-0006iK-Pr
 for kexec@lists.infradead.org; Wed, 02 Sep 2020 16:29:35 +0000
Date: Wed, 2 Sep 2020 18:29:31 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kexec/kexec.c: Add missing close() call
Message-ID: <20200902162931.GG21427@vergenet.net>
References: <1598403114-19103-1-git-send-email-tangyouling@loongson.cn>
 <faeb80e8-8d44-a0fb-bf7c-046df8b9433a@gonehiking.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <faeb80e8-8d44-a0fb-bf7c-046df8b9433a@gonehiking.org>
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
To: Khalid Aziz <khalid@gonehiking.org>
Cc: kexec@lists.infradead.org, Youling Tang <tangyouling@loongson.cn>, "Eric W. Biederman" <ebiederm@xmission.com>

On Wed, Aug 26, 2020 at 09:53:34AM -0600, Khalid Aziz wrote:
> On 8/25/20 6:51 PM, Youling Tang wrote:
> > Add missing close() call.
> > 
> > Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> > ---
> >  kexec/kexec.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kexec/kexec.c b/kexec/kexec.c
> > index a62b362..bb88caa 100644
> > --- a/kexec/kexec.c
> > +++ b/kexec/kexec.c
> > @@ -585,6 +585,7 @@ static char *slurp_file_generic(const char *filename, off_t *r_size,
> >  		die("Read on %s ended before stat said it should\n", filename);
> >  
> >  	*r_size = size;
> > +	close(fd);
> >  	return buf;
> >  }
> >  
> > @@ -1257,12 +1258,14 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
> >  	if (i == file_types) {
> >  		fprintf(stderr, "Cannot determine the file type " "of %s\n",
> >  				kernel);
> > +		close(kernel_fd);
> >  		return EFAILED;
> >  	}
> >  
> >  	ret = file_type[i].load(argc, argv, kernel_buf, kernel_size, &info);
> >  	if (ret < 0) {
> >  		fprintf(stderr, "Cannot load %s\n", kernel);
> > +		close(kernel_fd);
> >  		return ret;
> >  	}
> >  
> > 
> 
> This looks good to me.
> 
> Reviewed-by: Khalid Aziz <khalid@gonehiking.org>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
