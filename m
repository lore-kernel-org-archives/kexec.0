From: Matthew Wilcox <willy@infradead.org>
Date: Fri, 18 Mar 2022 13:50:11 +0000
Subject: [PATCH v4 4/4] fs/proc/vmcore: Use iov_iter_count()
In-Reply-To: <1592a861bd9e46e5adf1431ad6bbd25c@AcuMS.aculab.com>
References: <20220318093706.161534-1-bhe@redhat.com>
 <20220318093706.161534-5-bhe@redhat.com>
 <1592a861bd9e46e5adf1431ad6bbd25c@AcuMS.aculab.com>
Message-ID: <YjSOExYBbpZ7Hw8Z@casper.infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, Mar 18, 2022 at 01:48:07PM +0000, David Laight wrote:
> For some definition of 'cleaner' :-)
> 
> iter->count is clearly a simple, cheap structure member lookup.
> OTOH iov_iter_count(iter) might be an expensive traversal of
> the vector (or worse).
> 
> So a quick read of the code by someone who isn't an expert
> in the iov functions leaves them wondering what is going on
> or having to spend time locating the definition ...

Thank you for having an opinion.  Al's opinion, as the iov_iter
maintainer, trumps yours.

