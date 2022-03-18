From: David Laight <David.Laight@ACULAB.COM>
Date: Fri, 18 Mar 2022 13:48:07 +0000
Subject: [PATCH v4 4/4] fs/proc/vmcore: Use iov_iter_count()
In-Reply-To: <20220318093706.161534-5-bhe@redhat.com>
References: <20220318093706.161534-1-bhe@redhat.com>
 <20220318093706.161534-5-bhe@redhat.com>
Message-ID: <1592a861bd9e46e5adf1431ad6bbd25c@AcuMS.aculab.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

From: Baoquan He
> Sent: 18 March 2022 09:37
> 
> To replace open coded iter->count. This makes code cleaner.
...
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 4cbb8db7c507..ed58a7edc821 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -319,21 +319,21 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
>  	u64 start;
>  	struct vmcore *m = NULL;
> 
> -	if (iter->count == 0 || *fpos >= vmcore_size)
> +	if (!iov_iter_count(iter) || *fpos >= vmcore_size)

For some definition of 'cleaner' :-)

iter->count is clearly a simple, cheap structure member lookup.
OTOH iov_iter_count(iter) might be an expensive traversal of
the vector (or worse).

So a quick read of the code by someone who isn't an expert
in the iov functions leaves them wondering what is going on
or having to spend time locating the definition ...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


