From: Baoquan He <bhe@redhat.com>
Date: Wed, 13 Apr 2022 17:29:24 +0800
Subject: [PATCH v5 RESEND 0/3] Convert vmcore to use an iov_iter
In-Reply-To: <YlPt+3R63XYP22um@osiris>
References: <20220408090636.560886-1-bhe@redhat.com>
 <Yk//TCkucXiVD3s0@MiWiFi-R3L-srv> <YlPt+3R63XYP22um@osiris>
Message-ID: <YlaX9CxqPUvCN2dS@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 04/11/22 at 10:59am, Heiko Carstens wrote:
> On Fri, Apr 08, 2022 at 05:24:28PM +0800, Baoquan He wrote:
> > Add Heiko to CC.
> > 
> > On 04/08/22 at 05:06pm, Baoquan He wrote:
> > > Copy the description of v3 cover letter from Willy:
> > > ===
> > > For some reason several people have been sending bad patches to fix
> > > compiler warnings in vmcore recently.  Here's how it should be done.
> > > Compile-tested only on x86.  As noted in the first patch, s390 should
> > > take this conversion a bit further, but I'm not inclined to do that
> > > work myself.
> > 
> > Forgot adding Heiko to CC again.
> > 
> > Hi Heiko,
> > 
> > Andrew worried you may miss the note, "As noted in the first patch,
> > s390 should take this conversion a bit further, but I'm not inclined
> > to do that work myself." written in cover letter from willy.
> > 
> > I told him you had already known this in v1 discussion. So add you in CC
> > list as Andrew required. Adding words to explain, just in case confusion.
> 
> Thanks for letting me know again. I'm still aware of this, but would
> appreciate if I could be added to cc in the first patch of this
> series, so I get notified when Andrew sends this Linus.

Right, it's my neglect. I should CC all involved during the discussion.

By the way, could both of you, Heiko, Christoph, help check this
patchset and offer your ack again if it's OK to you? I removed
Christoph's Reviewed-by because there's some change as per Al's 
comment, and replace my own 'Acked-by' with 'Signed-off-by' according to
our posting rule.


