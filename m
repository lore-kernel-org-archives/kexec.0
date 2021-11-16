Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmtQM-000dpP-Bg
 for kexec@lists.infradead.org; Tue, 16 Nov 2021 08:02:40 +0000
Received: by mail-wm1-f72.google.com with SMTP id
 j193-20020a1c23ca000000b003306ae8bfb7so7001122wmj.7
 for <kexec@lists.infradead.org>; Tue, 16 Nov 2021 00:02:34 -0800 (PST)
Message-ID: <4289b936-e40c-cde8-eb08-0bd13c44eba3@redhat.com>
Date: Tue, 16 Nov 2021 09:02:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] proc/vmcore: fix clearing user buffer by properly
 using clear_user()
References: <20211112092750.6921-1-david@redhat.com>
 <20211115140444.bca2b88cfdd992760a413442@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
In-Reply-To: <20211115140444.bca2b88cfdd992760a413442@linux-foundation.org>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org

On 15.11.21 23:04, Andrew Morton wrote:
> On Fri, 12 Nov 2021 10:27:50 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> To clear a user buffer we cannot simply use memset, we have to use
>> clear_user(). With a virtio-mem device that registers a vmcore_cb and has
>> some logically unplugged memory inside an added Linux memory block, I can
>> easily trigger a BUG by copying the vmcore via "cp":
>>
>> ...
>>
>> Some x86-64 CPUs have a CPU feature called "Supervisor Mode Access
>> Prevention (SMAP)", which is used to detect wrong access from the kernel to
>> user buffers like this: SMAP triggers a permissions violation on wrong
>> access. In the x86-64 variant of clear_user(), SMAP is properly
>> handled via clac()+stac().
>>
>> To fix, properly use clear_user() when we're dealing with a user buffer.
>>
> 
> I added cc:stable, OK?
> 

I was a bit hesitant because this would (beofe the virtio-mem changes)
only trigger under XEN and I was wondering why nobody notices under XEN
so far. But yes, even though it only applies to the kdump kernel,
cc:stable sounds like the right think to do!

Thanks Andrew!

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
