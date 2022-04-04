From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 4 Apr 2022 14:34:43 -0700
Subject: [PATCH v5 0/3] Convert vmcore to use an iov_iter
In-Reply-To: <20220402043008.458679-1-bhe@redhat.com>
References: <20220402043008.458679-1-bhe@redhat.com>
Message-ID: <20220404143443.2258fc7e97b45172f7608a77@linux-foundation.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

> On Sat,  2 Apr 2022 12:30:05 +0800 Baoquan He <bhe@redhat.com> wrote:

You were on the patch delivery path, so these patches should have had
your signoff.  Documentation/process/submitting-patches.rst explains.

> Copy the description of v3 cover letter from Willy:
> ===
> For some reason several people have been sending bad patches to fix
> compiler warnings in vmcore recently.  Here's how it should be done.
> Compile-tested only on x86.  As noted in the first patch, s390 should
> take this conversion a bit further, but I'm not inclined to do that
> work myself.

We should tell the S390 maintainers this!

Can you please fix the signoff issue, add the S390 team to Cc and resend?

