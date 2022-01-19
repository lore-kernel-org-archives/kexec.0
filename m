From: David Hildenbrand <david@redhat.com>
Date: Wed, 19 Jan 2022 16:19:16 +0100
Subject: [PATCH v1] proc/vmcore: fix false positive lockdep warning
In-Reply-To: <ec19d477-a75c-1e5a-1c02-f62c8565f48d@redhat.com>
References: <20220119113702.102567-1-david@redhat.com>
 <YegpdRBSrkVBrwk3@boqun-archlinux>
 <ec19d477-a75c-1e5a-1c02-f62c8565f48d@redhat.com>
Message-ID: <035dc6b1-28cb-0563-c712-bf57ebbc91e8@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 19.01.22 16:15, David Hildenbrand wrote:
> On 19.01.22 16:08, Boqun Feng wrote:
>> Hi,
>>
>> On Wed, Jan 19, 2022 at 12:37:02PM +0100, David Hildenbrand wrote:
>>> Lockdep complains that we do during mmap of the vmcore:
>>> 	down_write(mmap_lock);
>>> 	down_read(vmcore_cb_rwsem);
>>> And during read of the vmcore:
>>> 	down_read(vmcore_cb_rwsem);
>>> 	down_read(mmap_lock);
>>>
>>> We cannot possibly deadlock when only taking vmcore_cb_rwsem in read
>>> mode, however, it's hard to teach that to lockdep.
>>>
>>
>> Lockdep warned about the above sequences because rw_semaphore is a fair
>> read-write lock, and the following can cause a deadlock:
>>
>> 	TASK 1			TASK 2		TASK 3
>> 	======			======		======
>> 	down_write(mmap_lock);
>> 				down_read(vmcore_cb_rwsem)
>> 						down_write(vmcore_cb_rwsem); // blocked
>> 	down_read(vmcore_cb_rwsem); // cannot get the lock because of the fairness
>> 				down_read(mmap_lock); // blocked
>> 	
>> IOW, a reader can block another read if there is a writer queued by the
>> second reader and the lock is fair.
>>
>> So there is a deadlock possiblity.
> 
> Task 3 will never take the mmap_lock before doing a
> down_write(vmcore_cb_rwsem).
> 
> How would this happen?

Ah, I get it, nevermind. I'll adjust the patch description.

Thanks!

-- 
Thanks,

David / dhildenb


