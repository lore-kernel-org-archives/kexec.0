From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sat, 1 Jan 2022 00:36:26 +0000
Subject: [PATCH v3 0/3] Convert vmcore to use an iov_iter
In-Reply-To: <20211213143927.3069508-1-willy@infradead.org>
References: <20211213143927.3069508-1-willy@infradead.org>
Message-ID: <Yc+iCla9zjUFkBXt@zeniv-ca.linux.org.uk>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, Dec 13, 2021 at 02:39:24PM +0000, Matthew Wilcox (Oracle) wrote:
> For some reason several people have been sending bad patches to fix
> compiler warnings in vmcore recently.  Here's how it should be done.
> Compile-tested only on x86.  As noted in the first patch, s390 should
> take this conversion a bit further, but I'm not inclined to do that
> work myself.

A couple of notes: please, use iov_iter_count(i) instead of open-coding
i->count.  And there's a preexisting nastiness in read_vmcore() -
generally, a fault halfway through the read() is treated as a short read,
rather than -EFAULT...

