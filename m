From: Baoquan He <bhe@redhat.com>
Date: Mon, 25 Apr 2022 11:40:17 +0800
Subject: [PATCH v5 RESEND 0/3] Convert vmcore to use an iov_iter
In-Reply-To: <20220408090636.560886-1-bhe@redhat.com>
References: <20220408090636.560886-1-bhe@redhat.com>
Message-ID: <YmYYIeU6qBDpCE4v@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Andrew,

On 04/08/22 at 05:06pm, Baoquan He wrote:
> Copy the description of v3 cover letter from Willy:
> ===
> For some reason several people have been sending bad patches to fix
> compiler warnings in vmcore recently.  Here's how it should be done.
> Compile-tested only on x86.  As noted in the first patch, s390 should
> take this conversion a bit further, but I'm not inclined to do that
> work myself.

Ping!

This patchset has got one ack, can we merge it now?

The lkp reported issue is not related to this patchset, but an existed
one. We can fix it in another patch.

Thanks
Baoquan


