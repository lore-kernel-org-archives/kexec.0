From: Baoquan He <bhe@redhat.com>
Date: Tue, 5 Apr 2022 17:04:51 +0800
Subject: [PATCH v5 0/3] Convert vmcore to use an iov_iter
In-Reply-To: <20220404143443.2258fc7e97b45172f7608a77@linux-foundation.org>
References: <20220402043008.458679-1-bhe@redhat.com>
 <20220404143443.2258fc7e97b45172f7608a77@linux-foundation.org>
Message-ID: <YkwGM9yVb1lZ2HL7@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 04/04/22 at 02:34pm, Andrew Morton wrote:
> > On Sat,  2 Apr 2022 12:30:05 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> You were on the patch delivery path, so these patches should have had
> your signoff.  Documentation/process/submitting-patches.rst explains.

OK, will update and repost after our IT replying and fixing the mail issue.

> 
> > Copy the description of v3 cover letter from Willy:
> > ===
> > For some reason several people have been sending bad patches to fix
> > compiler warnings in vmcore recently.  Here's how it should be done.
> > Compile-tested only on x86.  As noted in the first patch, s390 should
> > take this conversion a bit further, but I'm not inclined to do that
> > work myself.
> 
> We should tell the S390 maintainers this!
> 
> Can you please fix the signoff issue, add the S390 team to Cc and resend?

S390 maintainer has already known this. Heiko replied to v1 saying he
will take care of the s390 part, please see his comment from below link.
I will add Heiko in CC when resend.
https://lore.kernel.org/all/YbsGxJRo1153aykr at osiris/T/#u


