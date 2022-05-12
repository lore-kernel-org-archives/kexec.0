From: David Hildenbrand <david@redhat.com>
Date: Thu, 12 May 2022 10:42:46 +0200
Subject: [PATCH v8 2/7] crash: prototype change for
 crash_prepare_elf64_headers
In-Reply-To: <20220505184603.1548-3-eric.devolder@oracle.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-3-eric.devolder@oracle.com>
Message-ID: <c26a28cc-9955-9724-3271-602c9bddf8a2@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05.05.22 20:45, Eric DeVolder wrote:
> From within crash_prepare_elf64_headers() there is a need to
> reference the struct kimage hotplug members. As such, this
> change passes the struct kimage as a parameter to the
> crash_prepare_elf64_headers().

You should make it clearer that the hotplug members will be added by
successive patches.

> 
> This is preparation for later patch, no functionality change.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


