From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Apr 2022 11:49:39 +0200
Subject: [PATCH v7 1/8] x86/crash: fix minor typo/bug in debug message
In-Reply-To: <20220413164237.20845-2-eric.devolder@oracle.com>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-2-eric.devolder@oracle.com>
Message-ID: <6369fd69-5b59-1aa4-461e-237b3f128925@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 13.04.22 18:42, Eric DeVolder wrote:
> The pr_debug() intends to display the memsz member, but the
> parameter is actually the bufsz member (which is already
> displayed). Correct this to display memsz value.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb


