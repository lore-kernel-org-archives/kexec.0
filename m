From: Baoquan He <bhe@redhat.com>
Date: Fri, 1 Apr 2022 09:23:42 +0800
Subject: [PATCH v4 0/4] Convert vmcore to use an iov_iter
In-Reply-To: <20220331171407.0f7458c480e1c9406ca9337e@linux-foundation.org>
References: <20220318093706.161534-1-bhe@redhat.com>
 <YkWPrWOe1hlfqGdy@MiWiFi-R3L-srv>
 <YkW8d/HuXewjSuXs@casper.infradead.org>
 <20220331171407.0f7458c480e1c9406ca9337e@linux-foundation.org>
Message-ID: <YkZUHu1n7ZEaqLoq@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 03/31/22 at 05:14pm, Andrew Morton wrote:
> On Thu, 31 Mar 2022 15:36:39 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Thu, Mar 31, 2022 at 07:25:33PM +0800, Baoquan He wrote:
> > > Hi Andrew,
> > > 
> > > On 03/18/22 at 05:37pm, Baoquan He wrote:
> > > > Copy the description of v3 cover letter from Willy:
> > > 
> > > Could you pick this series into your tree? I reviewed the patches 1~3
> > > and tested the whole patchset, no issue found.
> > 
> > ... I'd fold patch 4 into patch 1,
> 
> I think so too, please.  The addition then removal of a
> read_from_oldmem() implementation is a bit odd.
> 
> > but yes, Andrew, please take these patches.
> 
> And against current -linus please.  There have been some changes since
> then (rcu stuff).

OK, I will fold 1 to 4, and send v5 based on linus's tree.


