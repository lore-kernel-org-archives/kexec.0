Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2983606A320
	for <kexec@archiver.kernel.org>; Sat, 21 Nov 2026 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=X/bnd/p+;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=cQuaJ2PH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=COzAhjVbmfh0aTzfpw6RJORDbydqu7ioBIDuIdRym7U=; b=X/bnd/p+tl5lbG
	deeRlzZ61AQHmTbZEwuVOpl4Kap1JUFQmUqeK2jjHjPL5XXrNIRRBJqfWKcW+DAaY5ZLbUZaOAjzT
	0aB37x0GD6K0gJGSPYOKuQd5OMvUAhQQw4NB8aus/QHM+ppdkJAYKrF4oIKJB998nRvXpJMjGHOFI
	I5g3C0DDUJgvfmmbsH/86AZorIBld5waKdA/swwj+2Z6cMN8Xx4G1DHC/we27nM7zDA0+q3BeMCf9
	npdhcmJlvMyHN9Rxy/jblpDltwyFGcRmRcAjZU32dMI2iiAiTdFg2BFYJX4xYbnNk9ozPxgHrrykv
	62RMK9e0CW7Tfx8EYFxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUq32-000000003nx-2maF;
	Sat, 21 Nov 2026 18:42:52 +0000
Received: from mout.gmx.net ([212.227.15.15])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUq30-000000003nQ-0LlG
	for kexec@lists.infradead.org;
	Sat, 21 Nov 2026 18:42:51 +0000
DKIM2-Signature: i=1; m=1; t=1795286564;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:eIW6VfqcZojih3ZM5yw3Sr368zSx
   ZWtoH086OG/1X1sEroLL/C10ch4080m+DhWQnw6z9VE/EHv75zrbccXjkU6rrFTrK3xgOqtc8uw
   lg/I0NFIl/4Sm/XQbvkE/YiEfA4VjgWi0YmwjR1B335jBz8dmloNP/XPIn+h53tZXxNKpcquHew
   1tbfcMF6SScTSGp+YckghWPyZRA+UDX0MLbP8WE4CP2DxXDSTO9jPiyjroRclk49UTcRUH9kQzP
   MP+DnkmiIN57flEmu34Xn47PIppmmUD7RcEdf1ijOeP4ALZUDoLgR0cib8/1GEUKY/UN205T7I7
   9RJ8S7PzwFKoKQ==;
Message-Instance: m=1;
 h=sha256:
   9hX6Vi/B9Hv3PDWacZB0A+5QXYLqQ5w6JqragjHYAdI=:
   QKx8Px9WLPLoeIWfnlHFcn/fyPG+z1kWlAgtVeZjdxk=,
  sha512:
   EFzOlUH0lGTgqxrNTmGu7jbx1WzuaLJUzoWDq9WrZLw5AmkL3rw+L1Rxd4m7wXZ84cVLJBEUrd3/54mb/azw6w==:
   VMGUTWuArLr3gFsvi58FsZMcPx6ggSnEdW8qcMf3DvJUxTaIrXm+eu0mgJYonJdi6af2789MRb1t6RkWIrJzCA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795286564; x=1795891364; i=deller@gmx.de;
	bh=COzAhjVbmfh0aTzfpw6RJORDbydqu7ioBIDuIdRym7U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cQuaJ2PHPhnHk7V7dYAcjkH3CYbG2gYIFkFnOic7EIRr0ejpdCN9xCB0hho3s8xp
	 2lyiCpqFh1DnXjW+SEce0IrkMpzIa/mb6lixPJGzT+n0+/VlaaJeQsw6BtlYOZS4y
	 vMxXSXFtQFEcQ8i9u/MuidAPdxDQFk9KYbffn9o+YabQERmr7Ib7NU46ZzORJBl1d
	 1CC8T17fgvSi0vav1P100aip3Cn4xxrDsBTcMQQOngVCLlj2irq1NfuiaLoE+HGLy
	 S13cclLDd1LHWmRo/A1tFRAzt8PFNkvMXQrgV4WayO//ec3DF50Oayg2VKLbqtdwJ
	 YYSu7/e/DPqKuFKNNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma20k-1y0e8W39tM-00UYqT; Sat, 21
 Nov 2026 19:42:44 +0100
Message-ID: <a35eccbf-2db2-47cd-8601-925a010406ca@gmx.de>
Date: Sat, 21 Nov 2026 19:42:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities in
 Kconfig.kexec
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
 <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
 <20261119080327.12916Ac7-hca@linux.ibm.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261119080327.12916Ac7-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+smbbP4uMuu4O7Oa4aqa6pgqXVvtYyhHMAIaCoU6MAtJ0BB/wCE
 E4BQ6Bo3q4GG7Ja1qrf4OZ3Ha3NuTV0SkI/dHCgc00KKxCHud3RbNn5dD1J/ZT47futv1rC
 oYPSS/FYtJA6K5aC7DUOdpqVfDWvty1GO03oUu0HIVxowMA1TnwMsubIUl1vdjIVxyhNcal
 Dv+ONnZ9Kz/xx4F7YTZTw==
UI-OutboundReport: notjunk:1;M01:P0:LKgGATiSpsU=;smme8Il0Fnh39TVGHwZDatLiAAI k6LPwc0S9memApeb7Y2SpjjP537WLdtKZ5S7cCbXIGW+3TMJFSRmGXNWV9yBdDhq5ZlXid7Cj ag++q4ceP+12U0msDL9+LnOJII62sObjWb6QCBdV5DxtMeB7Cr23nGWK5xfhlgoc37nSt457N jQthgWHkAbjrawS97JY9Ti+86Eu4sD5cfa+P/WwAikVaVlCLhVoB2u9CfH4f9xmVpDiXshXsn Q4xJ+IoR4+1vbNmsS++2A2dxXfWzyY9BQOInOU+Hqnv3C0XwF/DmCpuFnWEu2s3sLP++HDedz rFnW0sMxXFa90DMhYPDjGLeMP5HgSGFAAZoDNHwY5X46cyEK6NUMt4XOEkWUJvnuzlR4QXTp/ 2GWlw9L8mFBm3KZXNkNbil0mY6aN6E+khSjdXbSTN+6axLaH56TUyBu37x+AlNeulpvk6bVtB hIKP+jycwCqWr89nn52BC+sjjECGWEdFIfVB9sOqdut0OMee+IERlGoVS2/lWgHC/cMNJv2s4 DmWiUpaA4sX4RwcVcIFoYO97C/HTnoQz2hekQiTY/WSyyE2hbJnj4h8xngcGLthoKLEvj+GnX awjp2HpBIeR+c0J/62roe6RvY0JGekBoVbBhLdQnUwOjosHwqqpaFubv9tTyrPY9qJmbVnsLW VDnv0/CZRt24ST3Y4EH0DqBeMN6NxpWzrmMz/0H4AMbVgX4WEq9lXtBvKHj1w+vEeJit4jUiL kafpiBnP/oWKthuU/m4r0+UuBfOv/YdOnPSrVYt7IQM/JEJtmn4xJDTutnHSnkV8VsHKnlvb1 N72xGL/+7H3jSNiFIreqQr9RZAGPEAeuZbkgDFtqFj6iRYGG7rT0N0CpxIgmNJFZOj4eGUJDc DaA4wzZr5OZ5MhVXHAtsibsQWu32v1ifWUAd5nS3tz0SXRBP28DJ1WTFClkDwQa6ILDttcvFU SVdILGxZtfuBy/UOUosIMmVn3bNuF+cMwOUFWeJSCpepBgzgkrMbEfrZAhLd9FjG/LzF4Vu8p U8O/yO0T0JnrMwN54RAUu2HPuoSmqrET5hNZNs6RvJIWsnrnZ4FbldL97x9cL+e3NTE28S6Xq WMnZsgm1Rvdw9NIs4LA8af1fdJ6G1bP1JPAPENO/zjZx/RHWr9RzG2n4fsr6BwAFxeyELpwg6 qjLgx50yuGu3BCcrFwpHGt2w7OsNjoAHs729jRMYcWSAOrMil70ENr2oTewSuhyK25vTtzigt h470gzuq4uW5fxtHFJXxQbQYcD1sOviTwzjsin+H15drvjffsjhG81+1afokhtVKQk6XEZfdm Hb/TIP396iXw7Tr99FeNfiDoexzXiewGVJeFvqSzkjolDNjQrw/VAbxnwUGlUG8czOqFkSWPz 4b1f5lfC++KQCoB/6AsaYtP55IJUek4/7lXVv0UHAX2je1XISM8LlXfnIadoRxjcGPB0ieI3w C0qQoUKdV22oWFuSj2XZewX1F2a+I8kEfW6+TtnRtOxp0WDUApGbtbJerg8q2QxCN/stz7BEZ mwGp/lVpjlYB3Qz06yz36iC+pTrIz02vJ2RfBo4Mvb28Ya9dvaxCQ2H98YNHwQW1gUholE5fG dbHknehFwOMScVVO0HGFNg/Nu8/zqX8wOq671LQH9pDFTz12j6+hQ++qcMmxWaJBR9VBrE2xF niAu0vB3XGhFQGuript3m+hiYvTe4mvnu+HEp9O/rIWvwfQD911PHybW/E/Y/cSyJbatTsqLZ 4dz1kb49/YYaVjfKKeyqzSb5z3CO2vsV2QzHYztSNRoS5qsQOPbzSC81OPXdp4n3aNdEJQA56 a2HVGmEtMvR8FZL8w1zdvlsX3d4nnIPSLrwNjOqcZ1HaR+Ajno91C9aOw381JnikqVAirC5gV /treAIoguFrJHKDsP+wkSrXfXqEtFotnDIxFptSRxTxBk3gb2jHeofiSm89jW5mzQkuY5B1sv TJZLAP/G9FsgWsoBwr9uvxJdLylrar4tH4am1LJTeXBBP0uJh3FUazUK/nPKKTzcdKAKRf2VD CDJnunYfMfA8XGb0hNe4TO/inok3Bwqti/qOkSIgtUcOb7lyD4TdP4S2x0pvz7MiT4v3yU1ja CXF68T/rAf8uvjv6Kv0eVFlPR9ijaN94S3Mb7F00ZXt8BiyeTzDkg9t0T4/OrDasDiHr1Ta5x 5XwizMMAIskSlZiok6HErJxGkJ4OMYUyMdTeND8wr6nqTEq+wuwGesKrF1X0kj5AyytHpDg3h ACMbT12ii8gU/53z2WX5Nnx/4AM/eUU/Qz31loj9e5u4Mm/8Zgkrtrt7ulb+UsEPlIRU+Zwg7 osyn6BoJu0X+jwZIgtb4cuHJ6UIk0Bl7PEA5hzUCrzd0AkMsdsLk+/TtQ3YFfRyH/I2b031Su 84ySEKBzLtGQBVlgaibPtJemHdK1tF+Y2wDJuDcX+D5CVFjmoAWWwYxWX+QQ7yjVwns7GQEUW 8gQZ+cK4pcYNpsFXkyT2732TmoDlEtO1Dh09pzYQhkfIUwV6tuBYanf7w9nwWbtlpba5UELBY l5abxW3bOEY2sg+PJyuNtPL+lf2B/cCSiM2HyEYeDigskYNY/7mWBT4Yonoo4t7sX70J6eANR BtN2k8Ci7+6oFfuNe5KN7Vft2KstbKiNl9U6j9glpyebzcBPKPVimRh16k2HzZnKY4AhZZuuc OswZt/viyuZZWvXSZOw01J1GdRmpMZPDC8cCx6vTkq2bu963CwIBnxjuVR9PmUZv+QDXI5j+t pKaom1+tbrFQKzlEqf/TfrcLK1kRnKjVEfDlTO3kq9HIDxHyO68dHZWDBW1p5udjnNvPGuAzt /L5+GDR/c46a788m+D3bFy6tOVQXAvPpo9ET7bYm1Y9l+/nGkmtYNpdbNHwWuVVeA6WnsRMh2 kon0B/PQl9HIqIyGyVFoaj8bRmzNarhJg/iwxJnlY7riSegx4OA0yHEEcTZeTXfMekP1rlFhl /um/EGTn1uxzYcLetcpcvVpspm/myZYh5LxHoQ8hRSVTAl6Tloow6m37V5UWidJKgzCaIASMa f55KuVhJshpdfb2sk+fHmZb9w8TaocznETPoO2Ajn2rrR1uMnVpBCkI7z/9p0bC7/CQB9IVtZ pv8sOq9A6N8b1YqZd8yQx6tmfXkZ+yxjQ7YYmQ70qp3+jM7lE53mQza7ghaHirgDaVBFUF0y0 vUlCgbirNUi/bF4c6NBAkcPQhVxqWrKjWWHlT1KNuNRvc7+dlyG/fjTyr/4kPZ4BruzcJOrZg Vs/CgVXh8BVMmAbqgYgAa3AIufsVj/abk83dzbXK7FrxOhumKoEXYzVLZEF7V3Q3ncaHHD+XU mcmIDA9cqnaDopt1Hietz9vKvW5P9xMh5LD68+GiO2hx0IaBXZIIKExfOG2fnCNphxIXyyTzH 9hjkKf4XSyxi2JTlR/FeDAsVD1NZA/wG0UxbcSXiPAssNUPJUcoj8LGm9H/P+my/m1sUPYN3V CGSMMHx+vYyGTeyvArbchFIrDcF8brAUljLGkif0kBy/85W4/h1Zy8JHmaTxQXRfcyaVJqf4C 4mqPkDnofgOIIUVdgUiDpoKTPvPBodAMfSgTL6YE6tnxKuZgRh1Gz3BluLesNAZWyu15A9d4e UPMhhnDGyMm5+KrvKihPWychKEFVMabkabbPa5Gx4j/Y04vpt/ZrkxrTZlp75mj+qtyo8+dok jp1uECrQ63BZIxzUIrmW80Ms5iIP+evfMYWZLu5Fu8bu88PggNqk13WLZgrzQC+etI1Nb1u50 5Jz4Mh6PUK4XZYVAMzlG2lRjKg1UyYvT9ttns1m6duS+17g/LJGfz1uhrBKixifPfUAborbZR 8gzOJwDsPdF4YT8hKBy/RUAa/nGJCR4htMyUW+BnUnaubWI1ijMqjgk31FnDePCyqnjrpPdQN
 ODNCZsnd4CX0Nv+vjju+4HmTAmiQAivbVuud4N/v6YoxjYofLeoZWQ489MC71MuOL9jjxF4lC 5LspggalLoZeH5B4019uWJ9MSZaJMje+UuV3mySw1ub2BgFp3dHcGNCOnAlU6zT/UtMjCaaJV lADHt0w+ks9/uWxmMVZ12N54UNtfG38bZFUZ8joQP4uymj9rz5pP333nHfF7SiGfDwDpNeWrq 8UdAUgbpvOpHYSD1Z/TkDEO3CunscSG8c1fSRyme6N9cYQd1eksaww7EJWGKb2taJ27b2R3RP ISyeULTNBs9NeUtCBobEL31Rlwy7e4rhL/gxWpkIoSCVK5dAH6hsYrxfO7Kza6qI36/4pumRX in/nvcGyl8JcbWoqeExMw4aP5ZImbdoGPXrJAW5O6K7/UMw9z8Sw124maPucTo3Kfy7I48CA2 v7uK7UDksJsaSiQ/SdFKhtmM/fhtVhH0HzMPgH/+HoJc0y7IvT4CHtoJaq4Tjk7XulkpUNtIO hSnqLxMgkozEHJx8SNekQWdFIpK3Og7hSwgvwbbKxRJHEEhytVYxomXtpRqqKSD7eXR1K2uNc HVHLlnpVai/FNdNUnQH/xYJ09wqFaTs8P/g2pWquMdxG0Ck/uNKPRSpVhRqIo/eC57By4bEV5 uKi7G+nSibfFCYgQn9uHXUpRrKrUKrB3fwqQdsjAF94UMO58phJfLqiJmdXMdadTq7o/vrvBS kNZCyeebmauc3MbW/4rV9T6JzX5fg68AlUVwtncnxbgpsSjHerH1onwFkfN5G+Ou1sIsobTRE 4ivxvlOu1S8B6tn7wWwa8YEuV+93VxCOkn3nlDeyULUcH4Ztkp1X4tE5MHSJvz1pYl4kwOSwv RFriXsyZc4bCdxjx/BPgFvtHYD5mM6gJb/TxUxco51kmdHJnr/ahULuszEhpWzaWNQn4ctoBs extgb8t7lm4cE3Stcw8xkS0FwG343/XWoA3oxAsNe+QW8OaOwWTHWwgabkgI9UxVAenF9g+jn zseq7jT8rz+kDz1qNwcfRFoEx/hRXngplzJi9sBgCTtN+gj3DfessbwbAEK49YJyHvxFrO1mc AUfBT0oEhSG/Sm3GiOjnirfc961M4wajhiDFk2iD1gBDM2a1YDZcwnZk3kA1Jk3qcKmfcasAx Yzo6WPH3ApoKzNftm4cF/EFIrrwhXG81SnEVrjMni7m40daqzXgmXm4NlGl9XuIuBDH6rSRlv cO3dBgmck00deeUr31G9loc+yUtrtFt26nxXa/zs71K+XaC4Q0aUtva3pgquXdAGu+pz2JpDk DvdNf7f5GZe8IjiqwGgBwzTRoku9AqwWF7iyCP+QU5yOtFiLlwfDdHl7wWnxuEgfAWcFYrEUx p6+YXN8Y9T8O4Qb1Qr6UUG6Qn7xzfhHwB1gQujlm+JWO80mHWJMZArlEdnp974+xoda1N3y5W d8SU8OAVWGpsmWXrsd/FQyNf+wyG1yzmuLj2Fp/BSCVztnjrgs0cgSzd1BMGQC0GIgP1aZbxJ Kxf4vTiYmTUB7cfoSqcMjrR3mBF8gVKw1YpnYNsWI6s00UT3UCJYFFiI+hMXoJdlbZPZmsAuZ 7WfpQ0vJGCboz35Quza8bxg8FMqEk6gVKWvwtQ1KGwyjxx912Lw/Yys7fJKcDQpSe1tdgxsJ4 OewOHzCrpSr2RwUp1M9GPUcp+s/9PmG6lJeTnHAWa4KG1bQkvJdA97wByyYO/M39hdYFh6w13 r9Azn8s7H2qZPDZtFBaZnRbJhMW2Xnj1l7yJNzbFMlMRs5zcG+Af7FwsI3QMIiC1mujCA4mBn 7DMMYjyTVYTLGKRVfGpSdqEVlhdHcXaM3/ErRwmCRZkAs3g0/b4dZNtX/5N1dE2pmTXyhdfEH 8Cu+6VNOXjP4nX88daiCfc26bF8DN1ZS4Uc7XNKuP/N1q5Ye5jfeg2j2WM8uPBLTC70Er97wA Mx2lVhqBkAJd2B2+UrH3edEG7gKOdRFA6yhAbPm8n1TQ9WIrPsOfjjF6oFW+7BXYTNSkQM5dh h+WmtQ9mAWaQqj3yqWDD9dx/H6nnOAq6YQDGeJHgkN4HV9xq+1AyYYWLp9mwg9Ll2+0PQiRio 5NV/hlwbKOVlVtFc9kjKR1upkt9XVPCQpZ9/GHAB7pG9uBjrGiY4zxjq/ZYr4ITXKY9sqZNKV e7261vosZWbseII86FPN7VH7HMW6qT5UfJ/GSrE254nWy1UXCyponxNj83mXLB4DQxFym1VNL os9nx4Ig/fPk9tQszAVHQ7qoPkBICUGdNz3GEc1PgC/QXJdC4kBbHNddukMdTB3vexLJu6ApY LNKiN/vBG+zOOn+ZVzzYnNP7p0zVt7tz/LlMUmW40db3wYGb4yEsQrWp6j8oDy5qShD2U8PI5 He/RUHEYVNG9auLG6BjeksBo+VzCABJVjJLooTn8AclP5z7q/5s0J5HX9J/bcuDp6aL4Je+a3 7ejEeugI/DFo6Qk6MWMSxYaCnGpP4o9wApf2OHiiei4C8ML6j6zb84pSlJxnGsoZ94FKRiSY2 duoTaOpOezFvfgLA0gka6ux3DG64wjA7ZivQRzfkTw/bzEIIzEM4yLwjfUpA22gsyR88LJo7j yKyyiOdwZfaapXEfQuyJOq2TIxjy1AsgWabkLR2eSJqrpQiYBfH4UyNsWq2KZxQyPFYsoUXBA QgM1G+I++HurOeFYTEIO37DC2Rqfn1qa1pnrC67FmhIRNVvOrOx8tNtRCD4V4tJoLckJUEfMR TP9f/Qol6oTuNa9lbJD5fy2/hui4qUKwkVJhI7RLDnREoiuIquurOxMmPM35tn2C+OhTS5xop w+Pj2FiLw3n1qBOZuQPMb3ST1DfUfbQNynpbMoEEF9vOfwhYVaJTfHt/qksMIKRa7NdZa0H1q OivsZrEWO+Agl5tnshawM1n9qc1f7VlVSn8qZUw3uoByZXUy4p+V7ogyevfyxEekm9nTPREtY WMNzcBp4f7tBAHmxeOEs0y796LLiRf7AUyJfyc1wy/UdnKrrdmgTUQPEPKEIvZGmhd7IXtLOW I8UYeLaj42LX++MPBjozKh0/PN65Jkqpc8EDmAfOpfiOZjtRRdwgksmJyGLjnrhQC20LadNWR FZKoDaW3PxDNqbnG4yiQJ+olGqBwlUiOAebamYj8R5P+Cbe/BxzjBCHv8USKcoeQNP07okaZa M57U7EVby4Sg3gpFCMqVmtQS6+Bi3Uxa3kY3xBjSmuABLkegMY66ZYxQveKGxnbmoq1Sb/ZWv vnVJh7ojD86+hnPNiPQPD7GMaBufBveCHJjHDN3OOuePf80FOcREufBsfJOEiB/4R6lvjVg1A 9I9AB/5gdHMVVt5PoZjsd48MQXQ+VZAB0MP9JfyT4MSyVeX+w7tb88Fn9/r3OZ+o/QWVMPajO 8YFNhyaFJQSdNciuK55vwX1FPKe6XQIpgZh/T61dRY7rtkEp8asAkTv8z1h6uv/MU1dnwzhM4 QjnudMdazF7MAeJD4D9TX5V+jJ7jVppXaCU8LxyQPr2imkMWI4VfrYbr5eGKDWJuMpR32xgZJ okjeRF
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261121_104250_426987_361CCE9B 
X-CRM114-Status: UNSURE (   9.40  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 09:03, Heiko Carstens wrote:
> On Thu, Nov 19, 2026 at 08:16:58AM +0200, Mike Rapoport (Microsoft) wrot=
e:
>> The options that let an architecture opt in to kexec and crash dump
>> features, like ARCH_SUPPORTS_KEXEC or ARCH_SUPPORTS_CRASH_DUMP, are
>> defined in each architecture's Kconfig as def_bool, and most of them ar=
e
>> copied over several architectures.
>>
>> Declare these options once in kernel/Kconfig.kexec next to the options
>> that depend on them, similarly to how mm/Kconfig does it, and make the
>> architectures select them instead.
>>
>> Selection conditions are preserved, so there is no functional change.
>>
>> Acked-by: Baoquan He <baoquan.he@linux.dev>
>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> ---
>>   arch/arm/Kconfig       | 12 +++---------
>>   arch/arm64/Kconfig     | 36 +++++++++---------------------------
>>   arch/loongarch/Kconfig | 20 +++++---------------
>>   arch/m68k/Kconfig      |  4 +---
>>   arch/mips/Kconfig      | 12 +++---------
>>   arch/parisc/Kconfig    |  8 ++------
>>   arch/powerpc/Kconfig   | 30 +++++++-----------------------
>>   arch/riscv/Kconfig     | 28 +++++++---------------------
>>   arch/s390/Kconfig      | 28 ++++++----------------------
>>   arch/sh/Kconfig        | 16 ++++------------
>>   arch/x86/Kconfig       | 48 ++++++++++++-----------------------------=
=2D------
>>   kernel/Kconfig.kexec   | 42 +++++++++++++++++++++++++++++++++++++++++=
+
>>   12 files changed, 101 insertions(+), 183 deletions(-)
>=20
> Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390

Acked-by: Helge Deller <deller@gmx.de> # parisc


