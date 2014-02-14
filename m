Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WECJz-0007En-44
 for kexec@lists.infradead.org; Fri, 14 Feb 2014 06:32:23 +0000
Date: Fri, 14 Feb 2014 14:31:58 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH 1/4] add macro dbgprint_mem_range
Message-ID: <20140214063158.GD18964@dhcp-17-89.nay.redhat.com>
References: <1392297055-31934-1-git-send-email-chaowang@redhat.com>
 <1392297055-31934-2-git-send-email-chaowang@redhat.com>
 <20140213203505.GK30844@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140213203505.GK30844@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de

On 02/13/14 at 03:35pm, Vivek Goyal wrote:
> On Thu, Feb 13, 2014 at 09:10:52PM +0800, WANG Chao wrote:
> 
> [..]
> > diff --git a/kexec/kexec.h b/kexec/kexec.h
> > index 2bd6e96..753acc5 100644
> > --- a/kexec/kexec.h
> > +++ b/kexec/kexec.h
> > @@ -121,6 +121,16 @@ do { \
> >  		fprintf(stderr, __VA_ARGS__); \
> >  } while(0)
> >  
> > +#define dbgprint_mem_range(prefix, mr, nr_mr) \
> > +do { \
> > +	int i; \
> > +	dbgprintf(prefix "\n"); \
> > +	for (i = 0; i < nr_mr; i++) { \
> > +		dbgprintf("%016llx-%016llx (%d)\n", (mr)[i].start, \
> > +			  (mr)[i].end, (mr)[i].type);                \
> > +	} \
> > +} while (0)
> > +
> 
> Can we make it a function instead of macro? 

Sure. Will put it in kexec.c

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
