Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20200501165701.24587-1-james.morse@arm.com>
 <40b07632-b044-d1cd-96a2-81eec3da93e7@redhat.com>
 <8736892l92.fsf@x220.int.ebiederm.org>
 <a1c162fe-74de-c5ca-dadf-d451e970fdea@redhat.com>
 <87h7wmtna1.fsf@x220.int.ebiederm.org>
 <4d5f69b6-fdfd-a461-0ac9-6d05636508f1@redhat.com>
Date: Tue, 12 May 2020 06:59:38 -0500
In-Reply-To: <4d5f69b6-fdfd-a461-0ac9-6d05636508f1@redhat.com> (David
 Hildenbrand's message of "Tue, 12 May 2020 09:45:16 +0200")
Message-ID: <87sgg5s6s5.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: Discard loaded image on memory hotplug
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
To: David Hildenbrand <david@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, James Morse <james.morse@arm.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

David Hildenbrand <david@redhat.com> writes:
>> 
>> Maybe we have enough information to fixup the loaded kexec image
>> in the kexec_file_load case, we certainly don't in the ordinary
>> kexec_load case.
>
> Yes, that's also what I mentioned in my reply to Baoquan.
>
>> 
>> For now I want to stick to the simplest thing we can do which is either
>> blocking the memory hotplug operation (if that is possible) or
>> dropping the loaded kexec image.
>
> Yes, the latter is the best for now. It's simple.
>
> I am suggesting to add explicit callbacks to
> add_memory()/remove_memory(), and calling the invalidation from there -
> because I see various issues with the memory notifier approach (racy,
> false positives, never called if memory is not onlined).

Ok so we are in agreement.  Correct patch.  Wrong trigger condition.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
