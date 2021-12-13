Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 13 Dec 2021 13:42:34 +0000
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 3/3] vmcore: Convert read_from_oldmem() to take an iov_iter
Message-ID: <YbdNyjqSugLqsEXN@casper.infradead.org>
References: <20211213000636.2932569-1-willy@infradead.org>
 <20211213000636.2932569-4-willy@infradead.org>
 <20211213080257.GC20986@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213080257.GC20986@lst.de>
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
To: Christoph Hellwig <hch@lst.de>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@arm.com>, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:02:57AM +0100, Christoph Hellwig wrote:
> >  
> >  ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
> >  {
> > -	return read_from_oldmem(buf, count, ppos, 0,
> > +	struct kvec kvec = { .iov_base = buf, .iov_len = count };
> > +	struct iov_iter iter;
> > +
> > +	iov_iter_kvec(&iter, READ, &kvec, 1, count);
> > +
> > +	return read_from_oldmem(&iter, count, ppos,
> >  				cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
> >  }
> 
> elfcorehdr_read should probably also take an iov_iter while we're at it.

I don't like how that looks.  For example:

@@ -1246,11 +1247,14 @@ static int __init parse_crash_elf64_headers(void)
        int rc=0;
        Elf64_Ehdr ehdr;
        u64 addr;
+       struct iov_iter iter;
+       struct kvec kvec = { .iov_base = &ehdr, .iov_len = sizeof(ehdr) };

        addr = elfcorehdr_addr;

        /* Read Elf header */
-       rc = elfcorehdr_read((char *)&ehdr, sizeof(Elf64_Ehdr), &addr);
+       iov_iter_kvec(&iter, READ, &kvec, 1, sizeof(ehdr));
+       rc = elfcorehdr_read(&iter, &addr);
        if (rc < 0)
                return rc;

@@ -1277,7 +1281,10 @@ static int __init parse_crash_elf64_headers(void)
        if (!elfcorebuf)
                return -ENOMEM;
        addr = elfcorehdr_addr;
-       rc = elfcorehdr_read(elfcorebuf, elfcorebuf_sz_orig, &addr);
+       kvec.iov_base = elfcorebuf;
+       kvec.iov_len = elfcorebuf_sz_orig;
+       iov_iter_kvec(&iter, READ, &kvec, 1, elfcorebuf_sz_orig);
+       rc = elfcorehdr_read(&iter, &addr);
        if (rc < 0)
                goto fail;


I don't think this makes the code clearer, and it's already pretty ugly
code.  I'd rather leave constructing the iov_iter to elfcorehdr_read().
(Same remarks apply to elfcorehdr_read_notes())

> I also don't quite understand why we even need the arch overrides for it,
> but that would require some digging into the history of this interface.

I decided I didn't want to know ;-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
