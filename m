Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm6nam08on2052.outbound.protection.outlook.com
 ([40.107.102.52] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mC0Ov-00ChJp-Ek
 for kexec@lists.infradead.org; Fri, 06 Aug 2021 14:00:43 +0000
From: Zi Yan <ziy@nvidia.com>
Subject: Re: [RFC PATCH 13/15] mm: convert MAX_ORDER sized static arrays to
 dynamic ones.
Date: Fri, 06 Aug 2021 10:00:29 -0400
Message-ID: <81C3245C-6A47-4C1B-B392-CC08FBF15712@nvidia.com>
In-Reply-To: <bdec12bd-9188-9f3e-c442-aa33e25303a6@amd.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <20210805190253.2795604-14-zi.yan@sent.com>
 <586dda97-dc64-ade2-6736-a531e225acbc@amd.com>
 <0D3441BA-2A11-4BCA-BFD5-CAB8EB915B8F@nvidia.com>
 <bdec12bd-9188-9f3e-c442-aa33e25303a6@amd.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2427697588167177712=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Mike Kravetz <mike.kravetz@oracle.com>, Michal Hocko <mhocko@kernel.org>, John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@linux.ie>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org

--===============2427697588167177712==
Content-Type: multipart/signed;
 boundary="=_MailMate_2E952574-2F4B-48D5-8D2F-9B32358DA400_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"

--=_MailMate_2E952574-2F4B-48D5-8D2F-9B32358DA400_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 6 Aug 2021, at 5:37, Christian K=C3=B6nig wrote:

> Am 05.08.21 um 21:58 schrieb Zi Yan:
>> On 5 Aug 2021, at 15:16, Christian K=C3=B6nig wrote:
>>
>>> Am 05.08.21 um 21:02 schrieb Zi Yan:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> This prepares for the upcoming changes to make MAX_ORDER a boot time=

>>>> parameter instead of compilation time constant. All static arrays wi=
th
>>>> MAX_ORDER size are converted to pointers and their memory is allocat=
ed
>>>> at runtime.
>>> Well in general I strongly suggest to not use the patter kmalloc(size=
of(some struct) * MAX_ORDER,...) instead use kmalloc_array, kcalloc etc..=

>>>
>>> Then when a array is embedded at the end of a structure you can use a=
 trailing array and the struct_size() macro to determine the allocation s=
ize.
>> Sure. Will fix it.
>>
>>> Additional to that separating the patch into changes for TTM to make =
the maximum allocation order independent from MAX_ORDER would be rather g=
ood to have I think.
>> Can you elaborate a little bit more on =E2=80=9Cmake the maximum alloc=
ation order independent from MAX_ORDER=E2=80=9D?
>
> My idea was that you have a single patch to give the maximum order as p=
arameter to the TTM pool.

Got it. No problem.
>
>>  From what I understand of ttm_pool_alloc(), it tries to get num_pages=
 pages by allocating as large pages as possible, starting from MAX_ORDER.=
 What is the rationale behind this algorithm? Why not just call alloc_pag=
e(order=3D0) num_pages times?
>
> What we do here is essentially transparent huge pages for GPUs.
>
> In opposite to CPU which can usually only use fixed sizes like 4KiB, 2M=
iB, 1GiB at least AMD GPUs can use any power of two.

FYI, Matthew Wilcox=E2=80=99s memory folio patchset adds support for arbi=
trary THP sizes[1]. You might want to check it out. :)

>
> So it makes sense to allocate big pages as much as possible and only fa=
llback to 4KiB pages when necessary.
>
> Down side is that we potentially exhaust larger orders for other use ca=
ses.
>
>> Is it mean to reduce the number of calls to alloc_page?
>
> That is a nice to have side effect, but the performance improvement for=
 the TLB is the main reason here.
>
>> The allocated pages do not need to get as high as MAX_ORDER, is that t=
he case?
>
> Actually we would really like to have pages as large as 1GiB for best T=
LB utilization :)
>
>> If yes, I probably can keep ttm pool as static arrays with length of M=
IN_MAX_ORDER, which I introduce in Patch 14 as the lower bound of boot ti=
me parameter MAX_ORDER. Let me know your thoughts.
>
> Well you could do something like MAX_MAX_ORDER with a value of at least=
 19 (1GiB with 4KiB pages IIRC). And then limit to the real available max=
_order when you make that a run time option.
>
> Since the array elements consists only of a linked list and a few extra=
 parameters / pointers we probably won't need more than a page or two for=
 those.

Thanks for you explanation. Now I understand that ttm_pool does want page=
s as large as possible for performance reasons. I will keep the existing =
code, so that ttm_pool can get the largest pages from buddy allocator. I =
will separate the changes to TTM to a single patch like you suggested.


[1] https://lore.kernel.org/linux-mm/20210715033704.692967-1-willy@infrad=
ead.org

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_2E952574-2F4B-48D5-8D2F-9B32358DA400_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmENQH0PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKllQQAK5Nu3fHcUsKBNa9pN7Da8p7vJYw/Dx6wKn4
ZA15nANRcXpPUfNnT/8EweDsgKv/PCTRpJcmqvbOjV9NjusmgB4un3KA0jqVnP7E
5YVHfa2b+WgIThYOrsD/hkspLqxjPIqfwcYAtPNNplOtjfvneQcbKaTM4YhhrIVI
dH+KyXeGt3HqGUk8Xv/Rhr2p3bOkJSpXF7c3k3clohjgTAAT3pXyDC4rcCMBUwvn
D06JKXaabr8yRk4nIAQtYyUVAVS2b6nts3NdSUlC+Rr6+HyHJB9NpX2OgTq8AKRg
8I8LFAbwUjVW1rr1GD5dPvghmeZgqziknh/W9PKbcC7ydA11ofqwib6vy9WlQr5r
qvN/zWjWyTRzI9+owG+sa0iXr5ji2CqNpUTm3glqLyDmJW7orlyUjjVlHdLKqDBL
PhK8IMjnpcjlFjyv5dKE5GgMe3kffJG1IJgCtCse58IJTKF5vK3liqq0HK8UIHD3
UnGKTL45O7rCuLP7CEFmzS6EL9vtTdEq3n6/sllLZGIQQ3rRwiwkjKXykLL7f831
8Ptm9q/Jzy0zn1rdYeMppoO9cBJq5QTpNlu+pasXwHJhVqGBRY3jk7x7q3p/XQrB
aLcGMG0QaN90F/UA2yl/0dHRmCoV3eaSNrXz82xjDw+vEPQ4BEQXh4GREEUcP+Zx
rZTvuv95
=R4Zs
-----END PGP SIGNATURE-----

--=_MailMate_2E952574-2F4B-48D5-8D2F-9B32358DA400_=--


--===============2427697588167177712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2427697588167177712==--

