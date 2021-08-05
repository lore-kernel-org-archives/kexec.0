Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com
 ([40.107.94.53] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBjVr-00AgnF-Tx
 for kexec@lists.infradead.org; Thu, 05 Aug 2021 19:58:45 +0000
From: Zi Yan <ziy@nvidia.com>
Subject: Re: [RFC PATCH 13/15] mm: convert MAX_ORDER sized static arrays to
 dynamic ones.
Date: Thu, 05 Aug 2021 15:58:32 -0400
Message-ID: <0D3441BA-2A11-4BCA-BFD5-CAB8EB915B8F@nvidia.com>
In-Reply-To: <586dda97-dc64-ade2-6736-a531e225acbc@amd.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <20210805190253.2795604-14-zi.yan@sent.com>
 <586dda97-dc64-ade2-6736-a531e225acbc@amd.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6339006825953355862=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Mike Kravetz <mike.kravetz@oracle.com>, Michal Hocko <mhocko@kernel.org>, John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@linux.ie>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org

--===============6339006825953355862==
Content-Type: multipart/signed;
 boundary="=_MailMate_4B2EA1D0-8700-4B85-88FC-290FD6C94B08_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"

--=_MailMate_4B2EA1D0-8700-4B85-88FC-290FD6C94B08_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 5 Aug 2021, at 15:16, Christian K=C3=B6nig wrote:

> Am 05.08.21 um 21:02 schrieb Zi Yan:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> This prepares for the upcoming changes to make MAX_ORDER a boot time
>> parameter instead of compilation time constant. All static arrays with=

>> MAX_ORDER size are converted to pointers and their memory is allocated=

>> at runtime.
>
> Well in general I strongly suggest to not use the patter kmalloc(sizeof=
(some struct) * MAX_ORDER,...) instead use kmalloc_array, kcalloc etc..
>
> Then when a array is embedded at the end of a structure you can use a t=
railing array and the struct_size() macro to determine the allocation siz=
e.

Sure. Will fix it.

>
> Additional to that separating the patch into changes for TTM to make th=
e maximum allocation order independent from MAX_ORDER would be rather goo=
d to have I think.

Can you elaborate a little bit more on =E2=80=9Cmake the maximum allocati=
on order independent from MAX_ORDER=E2=80=9D? From what I understand of t=
tm_pool_alloc(), it tries to get num_pages pages by allocating as large p=
ages as possible, starting from MAX_ORDER. What is the rationale behind t=
his algorithm? Why not just call alloc_page(order=3D0) num_pages times? I=
s it mean to reduce the number of calls to alloc_page? The allocated page=
s do not need to get as high as MAX_ORDER, is that the case? If yes, I pr=
obably can keep ttm pool as static arrays with length of MIN_MAX_ORDER, w=
hich I introduce in Patch 14 as the lower bound of boot time parameter MA=
X_ORDER. Let me know your thoughts.

Thanks.

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_4B2EA1D0-8700-4B85-88FC-290FD6C94B08_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmEMQugPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK9IAP/1sWI6g4F8/TjyPqAnf9fJ900swOrmgQEmZg
z5Gy4K0ZkagwjucAwQq+dAw/Ebii5ZtQx2mqjx5aSyfp+I1ErcNJ0qNqKTWTjcQD
g/3hssNG6gmrf6mMstWHtediyWMkhH4WMCixpHocBZwE+3/zyyMtGHyOkLuAd5Ul
1nKtZc7CjgFM3FN3UeyV24HqLodhNIDYcQ5RHcHH+rNGBtoyScuZysYHFXBgNpkL
84S2xolvUObyDIHaVPPOhMI+zLZEJ8q3hOp+2ARqDS/2PsA9jtU+ICJjV4sslwnu
chz1J49n36SwEf+Kq5Cgm5iTrOnp7ziBthQgxDk99qRNoV/pgI4Wb7AEI6EeYiDp
6ImZD3ZzhQ7dXGGpaRCYBmYDQGSN+UAUZJlccq5QYhtSWwjAgfkAtBkD7tE9FZgc
AGXJS5XZDvRDD145vPvwWSYbMslQsWvTUiX37JubqF6rtplLfNy9P/REPaq2bkJX
TCqBYWfrprvo6wfdvjmdFbBGV+K/VWMXlri8U3Uf7QTNrAccY/oXODCF1m/kn0w8
4aUFr8I1I5SI+HgLRz12CHxzn151Py2aubN2DtIFN/+lpKUyOd3eSAPoA+O1W0rY
yEHamf+O9gZ00Kw9cqf25zxpGuGsBDKGOpecmD+yI5lb0B05+zHpsnM9PeCWO3Vq
FaQ3HpsL
=DyTs
-----END PGP SIGNATURE-----

--=_MailMate_4B2EA1D0-8700-4B85-88FC-290FD6C94B08_=--


--===============6339006825953355862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============6339006825953355862==--

