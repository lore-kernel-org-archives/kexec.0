From: Baoquan He <bhe@redhat.com>
Date: Thu, 27 Jan 2022 17:44:56 +0800
Subject: [PATCH v3 0/3] Convert vmcore to use an iov_iter
In-Reply-To: <Yc+iCla9zjUFkBXt@zeniv-ca.linux.org.uk>
References: <20211213143927.3069508-1-willy@infradead.org>
 <Yc+iCla9zjUFkBXt@zeniv-ca.linux.org.uk>
Message-ID: <20220127094456.GD13508@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi,

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

Willy must be busy with those tons of folio patches, since I have acked
this patchset, I will update them as per your comment and repost them
with v4.

Thanks for checking.


