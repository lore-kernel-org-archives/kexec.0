From: Baoquan He <bhe@redhat.com>
Date: Fri, 25 Feb 2022 16:28:39 +0800
Subject: [PATCH v3 0/3] Convert vmcore to use an iov_iter
In-Reply-To: <Yc+iCla9zjUFkBXt@zeniv-ca.linux.org.uk>
References: <20211213143927.3069508-1-willy@infradead.org>
 <Yc+iCla9zjUFkBXt@zeniv-ca.linux.org.uk>
Message-ID: <YhiTN0MORoQmFFkO@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 01/01/22 at 12:36am, Al Viro wrote:
> On Mon, Dec 13, 2021 at 02:39:24PM +0000, Matthew Wilcox (Oracle) wrote:
> > For some reason several people have been sending bad patches to fix
> > compiler warnings in vmcore recently.  Here's how it should be done.
> > Compile-tested only on x86.  As noted in the first patch, s390 should
> > take this conversion a bit further, but I'm not inclined to do that
> > work myself.
> 
> A couple of notes: please, use iov_iter_count(i) instead of open-coding
> i->count.  And there's a preexisting nastiness in read_vmcore() -
> generally, a fault halfway through the read() is treated as a short read,
> rather than -EFAULT...

Sorry for being late to work on this.

While checking it, I noticed it's generic to return -EFAULT in kernel.
E.g in kernfs_file_read_iter(). Even though 'man 3 read' does give the
same words as you noted.

However, the manpage says the less then nbyte case happened just in case
the number of bytes left in the file is less than nbyte. The returning
-EFAULT in read_vmcore() seems to be a little different and not
satisfying the condition, because the left bytes should be greater than
the nbyte when reading out the elf note, or the middle of the vmcore. So
we should leave it as is?

Abstract from man page of read:
====
Upon successful completion, where nbyte is greater than 0, read() shall mark for update the last data access timestamp of the
file, and shall return the number of bytes read.  This number shall never be greater than nbyte.  The value returned  may  be
less  than  nbyte if the number of bytes left in the file is less than nbyte, if the read() request was interrupted by a sig?
nal, or if the file is a pipe or FIFO or special file and has fewer than nbyte bytes immediately available for  reading.  For
example, a read() from a file associated with a terminal may return one typed line of data.
====


