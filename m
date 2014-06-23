Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wz4jC-0004YL-Pe
 for kexec@lists.infradead.org; Mon, 23 Jun 2014 13:56:12 +0000
Subject: Re: [PATCH] Makedumpfile: vmcore size estimate
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
From: Anders Rayner-Karlsson <akarlsso@redhat.com>
In-Reply-To: <20140623130533.GA1616@dhcp-17-102.nay.redhat.com>
Date: Mon, 23 Jun 2014 15:55:38 +0200
Message-Id: <27DABA11-871D-43EB-8F06-C72E627B9BF5@redhat.com>
References: <1402490345-18656-1-git-send-email-bhe@redhat.com>
 <20140623123654.GA29112@redhat.com>
 <20140623130533.GA1616@dhcp-17-102.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6532703971185469403=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: Barros Guilherme <gbarros@redhat.com>, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>


--===============6532703971185469403==
Content-Type: multipart/signed; boundary="Apple-Mail=_179918EE-4B95-4E78-83F9-A9981F8D3342"; protocol="application/pgp-signature"; micalg=pgp-sha256


--Apple-Mail=_179918EE-4B95-4E78-83F9-A9981F8D3342
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 23 Jun 2014, at 15:05, Baoquan He <bhe@redhat.com> wrote:

> On 06/23/14 at 08:36am, Vivek Goyal wrote:
>> On Wed, Jun 11, 2014 at 08:39:05PM +0800, Baoquan He wrote:
>>> sudo makedumpfile -E -d 31 --vmcore-estimate /proc/kcore =
/var/crash/kcore-dump
>>>=20
>>> Questions:
>>> 1. Or we can get the dumpable page numbers only, then calculate the =
estimated
>>> vmcore size by a predifined factor if it's kdump compressed dumping. =
E.g if
>>> lzo dump, we assume the compression ratio is 45%, then the estimate =
size is
>>> equal to: (dumpable page numbers) * 4096* 45%.
>>=20
>> I think that we can probably not guess the saving from compression.
>> Compression ratio varies based on content of page. So if we keep it =
simple
>> and just calculate the number of pages which will be dumped and =
multiply
>> it by page size, that number will be much more accurate (for current
>> system).
>=20
> Yeah, this is another plan. Then the output will be the size of elf
> dump. If user configured the kdump compression, such as lzo/snappy, =
they
> can just estimate it by themselves. It's OK if user can accept this
> since this is much more accurate.
>=20
> Hi Anders,
>=20
> Do you have any comments on this? I found you are concerned with this
> issue too.

Hi there,

Only comment I have is that I like your approach and that I agree
we will not be able to accurately predict compression ratio. While
we could run the compression to get an accurate prediction, it
would not be accurate five minutes later, so best not to go there
at all. Just being able to tell how big the dump will be at a
specific dumplevel, uncompressed, will be very welcome by customers
and partners.

Because it allows them to gauge how much space they need to set
aside for /var/crash or where ever they need to write the dump.
The old perl script I did after speaking with Neil Horman was only
every able to predict dumplevel 31, but not all of the time is
that enough. Changing to 17 or 1 for a specific problem, they want
to know how much space they need for that.

So, I am very happy to see this effort underway. :)

Thank you,

--
Anders Rayner-Karlsson / akarlsso@redhat.com / +46-76-805-2173
Principal Technical Account Manager & Support Account Director
         Red Hat Strategic Customer Engagement Team



--Apple-Mail=_179918EE-4B95-4E78-83F9-A9981F8D3342
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.22 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBCAAGBQJTqDHaAAoJEF3ybC1jQfJj7acP/1eQggDV7dbwI20Z7P7Sycm+
8jBVkkQjlOAKOfB9fvSM++WEm0J6rvXc71zm1DjI4vzohzHdJ31D48blT5naqEhQ
oy0kWPlpkY6S7uwB4DKAqxdAGjv4I5KR3whb3V3lqK05ZmICgz5v6FeWZbOWfL+c
VlG92LWuQ1KKZFrGNlvmuK2RFyNwtIzij/UOSgwLZYH/MYucH+pOkoFGUjt0ZSKh
+8wGoVyPrdrrupkzx5aTY1jY9yLM96sOLHanNlQWYp20fMRhkB2hNNIDJHdcCr7t
PaHeG3YfSR9JxEgFeWgcqUk+qeNPYFhWnhwj1tP0mY0tO9h6LvjOxtWc+yR5wAif
JULqG9kFPhaWkq9gVe31t7251vc3hmf1Ia1YJrPtKiW5mDXK/UO+9LX/apNwt80x
7Z2v252SYq3ZHsfpEf2GuyI6IyyyC+4NVsOtHvSd7HKf2dDlHqjjRxhgHEx+rmYa
2mTPqkeKlk6nHcbJtuXCSO1QdlTKbLI9AVTrIIpdorWtEMuFvbRvYbASB5WX6rfZ
VKOMNXNfOP+34mcJQayhn7T3DP8Eg+wdwCAVNI/yjQXgEKVOzp18QU9VJjG+Lwea
XMPIUQBMvqLx56peiSLZpNOwoYpQ36ri8XZ2zkuiOf9IQTfHTa8C5dxVh81asKmf
67/JLdCltDe2JdvLHiiD
=ecMg
-----END PGP SIGNATURE-----

--Apple-Mail=_179918EE-4B95-4E78-83F9-A9981F8D3342--


--===============6532703971185469403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============6532703971185469403==--

