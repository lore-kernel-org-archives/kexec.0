From: 'Baoquan He' <bhe@redhat.com>
Date: Mon, 21 Mar 2022 11:54:50 +0800
Subject: [PATCH v4 4/4] fs/proc/vmcore: Use iov_iter_count()
In-Reply-To: <1592a861bd9e46e5adf1431ad6bbd25c@AcuMS.aculab.com>
References: <20220318093706.161534-1-bhe@redhat.com>
 <20220318093706.161534-5-bhe@redhat.com>
 <1592a861bd9e46e5adf1431ad6bbd25c@AcuMS.aculab.com>
Message-ID: <Yjf3CivCFMNE/Hbs@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi David,

On 03/18/22 at 01:48pm, David Laight wrote:
> From: Baoquan He
> > Sent: 18 March 2022 09:37
> > 
> > To replace open coded iter->count. This makes code cleaner.
> ...
> > diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> > index 4cbb8db7c507..ed58a7edc821 100644
> > --- a/fs/proc/vmcore.c
> > +++ b/fs/proc/vmcore.c
> > @@ -319,21 +319,21 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
> >  	u64 start;
> >  	struct vmcore *m = NULL;
> > 
> > -	if (iter->count == 0 || *fpos >= vmcore_size)
> > +	if (!iov_iter_count(iter) || *fpos >= vmcore_size)
> 
> For some definition of 'cleaner' :-)
> 
> iter->count is clearly a simple, cheap structure member lookup.
> OTOH iov_iter_count(iter) might be an expensive traversal of
> the vector (or worse).
> 
> So a quick read of the code by someone who isn't an expert
> in the iov functions leaves them wondering what is going on
> or having to spend time locating the definition ...

Thanks for reviewing and looking into this.

People may have the same feeling as you when looking at codes at the
first glance. While usually we all use editor to explore codes, so.

Basically, I noticed putting open code into wrapper is a tendency, see a
lot of patches to clean up open code in sub component. About the extra
cost of wrapper, I believe it does have. It should be one of reasons
in some places open code is necessary. However, in fs/proc/vmcore, I
don't have the worry since it's very tiny and can be ignorable.

Thanks
Baoquan


