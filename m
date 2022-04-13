From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 12 Apr 2022 19:27:34 -0700
Subject: [PATCH v2 0/2] x86/kexec: fix memory leak of elf header buffer
In-Reply-To: <YkWRQdp7TxV22ygO@MiWiFi-R3L-srv>
References: <20220223113225.63106-1-bhe@redhat.com>
 <YkWRQdp7TxV22ygO@MiWiFi-R3L-srv>
Message-ID: <20220412192734.fcda8988d189c8e2e2830b03@linux-foundation.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, 31 Mar 2022 19:32:17 +0800 Baoquan He <bhe@redhat.com> wrote:

> Hi Andrew,
> 
> On 02/23/22 at 07:32pm, Baoquan He wrote:
> > The memory leak is reported by kmemleak detector, has been existing
> > for very long time. It casue much memory loss on large machine
> > with huge memory hotplug which will trigger kdump kernel reloading
> > many times, with kexec_file_load interface.
> 
> Could you merge these two patches? Or should I ping x86 maintainers to
> take them? 

Ah, sorry, I tend to fall asleep if there's "x86" in the subject. 
Poking a sleeping Andrew is always the right thing to do.  Shall look
at them.


