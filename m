From: Heiko Carstens <hca@linux.ibm.com>
Date: Mon, 11 Apr 2022 10:59:39 +0200
Subject: [PATCH v5 RESEND 0/3] Convert vmcore to use an iov_iter
In-Reply-To: <Yk//TCkucXiVD3s0@MiWiFi-R3L-srv>
References: <20220408090636.560886-1-bhe@redhat.com>
 <Yk//TCkucXiVD3s0@MiWiFi-R3L-srv>
Message-ID: <YlPt+3R63XYP22um@osiris>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, Apr 08, 2022 at 05:24:28PM +0800, Baoquan He wrote:
> Add Heiko to CC.
> 
> On 04/08/22 at 05:06pm, Baoquan He wrote:
> > Copy the description of v3 cover letter from Willy:
> > ===
> > For some reason several people have been sending bad patches to fix
> > compiler warnings in vmcore recently.  Here's how it should be done.
> > Compile-tested only on x86.  As noted in the first patch, s390 should
> > take this conversion a bit further, but I'm not inclined to do that
> > work myself.
> 
> Forgot adding Heiko to CC again.
> 
> Hi Heiko,
> 
> Andrew worried you may miss the note, "As noted in the first patch,
> s390 should take this conversion a bit further, but I'm not inclined
> to do that work myself." written in cover letter from willy.
> 
> I told him you had already known this in v1 discussion. So add you in CC
> list as Andrew required. Adding words to explain, just in case confusion.

Thanks for letting me know again. I'm still aware of this, but would
appreciate if I could be added to cc in the first patch of this
series, so I get notified when Andrew sends this Linus.

Thanks a lot!

