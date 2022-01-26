From: Baoquan He <bhe@redhat.com>
Date: Wed, 26 Jan 2022 09:22:04 +0800
Subject: [PATCH v2] proc/vmcore: fix possible deadlock on concurrent mmap
 and read
In-Reply-To: <20220125170900.472fdb649312e77a4a60d9da@linux-foundation.org>
References: <20220119193417.100385-1-david@redhat.com>
 <20220125170900.472fdb649312e77a4a60d9da@linux-foundation.org>
Message-ID: <20220126012204.GA2086@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 01/25/22 at 05:09pm, Andrew Morton wrote:
> On Wed, 19 Jan 2022 20:34:17 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
> > Lockdep noticed that there is chance for a deadlock if we have
> > concurrent mmap, concurrent read, and the addition/removal of a
> > callback.
> > 
> > As nicely explained by Boqun:
> > 
> > "
> > Lockdep warned about the above sequences because rw_semaphore is a fair
> > read-write lock, and the following can cause a deadlock:
> > 
> > 	TASK 1			TASK 2		TASK 3
> > 	======			======		======
> > 	down_write(mmap_lock);
> > 				down_read(vmcore_cb_rwsem)
> > 						down_write(vmcore_cb_rwsem); // blocked
> > 	down_read(vmcore_cb_rwsem); // cannot get the lock because of the fairness
> > 				down_read(mmap_lock); // blocked
> 
> I'm wondering about cc:stable.  It's hard to believe that this is
> likely to be observed in real life.  But the ongoing reports of lockdep
> splats will be irritating.

This is reported by Redhat CKI on Fedora ARK kernel. That kernel enables
many debug feature by default, that's why lockdep detected that. Usually
kdump kernel add 'nr_cpus=1' by default in our distros, so it won't
hurt. It may cause lock issue in theory, so should be false positive
warning. Since it has Fixes tag, cc:stable should be OK.


