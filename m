From: Eric DeVolder <eric.devolder@oracle.com>
Date: Thu, 12 May 2022 11:10:11 -0500
Subject: [PATCH v8 2/7] crash: prototype change for
 crash_prepare_elf64_headers
In-Reply-To: <c26a28cc-9955-9724-3271-602c9bddf8a2@redhat.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-3-eric.devolder@oracle.com>
 <c26a28cc-9955-9724-3271-602c9bddf8a2@redhat.com>
Message-ID: <093ebfa2-9584-ab89-9d52-f21b2841ec56@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 5/12/22 03:42, David Hildenbrand wrote:
> On 05.05.22 20:45, Eric DeVolder wrote:
>>  From within crash_prepare_elf64_headers() there is a need to
>> reference the struct kimage hotplug members. As such, this
>> change passes the struct kimage as a parameter to the
>> crash_prepare_elf64_headers().
> 
> You should make it clearer that the hotplug members will be added by
> successive patches.
I've tweaked the commit message to indicate as such.

> 
>>
>> This is preparation for later patch, no functionality change.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
> 
> Acked-by: David Hildenbrand <david@redhat.com>
Thank you!
eric

> 

