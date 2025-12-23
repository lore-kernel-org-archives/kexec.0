Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A6FE748FC
	for <kexec@archiver.kernel.org>; Tue, 23 Dec 2025 22:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FCy8NHxeH9DflYZYms3qcuTMJmKxws5qGU/nJeanNTg=; b=LbkX5kgelmiGpffj7H9EeLKl/A
	Dw4rbA1zxxSWTFx3EX7vL3ZwzsTctvBURRa6livgXbjc980MEM4yWJFE72cMWSZucXCxzK/03mGma
	HNHCPZ/M9kf5wRaEPkFRPTuZlgBJKi791YrbrgAqiuPIMB2IZEfLpi39VfShL3d2V9yPD0/Lh5669
	Y9U1VWcRYp0YEWqLf8dyovzrkCh7PN9+6ucHXgWOFtwhoy5LC/HKWcuftnirpvPWdp5SVa0u82mLm
	40QXRqUG7pBeJY84a5F9dJbD1IlQsbi0gYy21xoCaRgWGqMb8ePYlbNE/oHKzhTwWqcRjWJEs4dXG
	czr5f65A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYAmF-0000000G8hV-1Myd;
	Tue, 23 Dec 2025 22:22:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYAmB-0000000G8gy-2goq
	for kexec@lists.infradead.org;
	Tue, 23 Dec 2025 22:22:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766528560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCy8NHxeH9DflYZYms3qcuTMJmKxws5qGU/nJeanNTg=;
	b=Mj1Lha+mcNM6m4V+xAb3ljybEplxCWViVDPtjLsHqQRDVNHhwgrqiWTcd0nVWYrq6xG1k1
	tG+96PsHv6yS6xkPP5BAUaf1uEveo0d3XUj98Csl+FtDsj/200bSsUgKevVrQ0JC29jsq2
	+1vOYW59F8rl7CyDbMXaBa6avUVHIa0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-KD9jDcviPSek7_heszl03w-1; Tue, 23 Dec 2025 17:22:38 -0500
X-MC-Unique: KD9jDcviPSek7_heszl03w-1
X-Mimecast-MFC-AGG-ID: KD9jDcviPSek7_heszl03w_1766528558
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f4ab58098eso119062141cf.1
        for <kexec@lists.infradead.org>; Tue, 23 Dec 2025 14:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766528558; x=1767133358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FCy8NHxeH9DflYZYms3qcuTMJmKxws5qGU/nJeanNTg=;
        b=o3Fp3NRODImJz088O5NUunir1a2BgZUVtwh/iQUaaOwhawJ6tEO57g5zyAeHlzEPk4
         bXN7QFLbB/aTMKx3sY0U1peA70UT0WJagIDyU6e8t4qbkPPxKSpxIbP056wHoQYBVs9s
         xXkPJ+MqM+qEZgAnREYpRDVQ1XcPriICtNbWySYtCJ+9poT/tvUa8uAVE8H02a79nsvE
         sUl+Di2G20S+QP0hByTERyu/plaE+8lbLBk1ZtK4Tieix965sPraKQpzfelilFDjop+X
         6uqTPY1haS+kbvgDPk/ymgKkSRUsG4dbsF6ifrIH5OoulD3U7gCh/kSXYCyTZH4W4V54
         JBfg==
X-Forwarded-Encrypted: i=1; AJvYcCVybuim55P5TP+2a+xJLvQ/fcsivs5a929QDXxQ+Fo1Jsm5yZd1sJdhody593apdlg+YBH28A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwKsVZGwgnvkZgybYoORhVJrk6cBdU0qjB5Ok1A7xYCmc6NOwZr
	jrohllu19u5DBcxUl64RWb+EGONsCqWXoAJWGY7nA7oRWS42Hsn5kusT9yFSZdjmMsYAV/AycM9
	kb6mDpLdtgkEZZy7MaCmyMtM7LhQ+Z+vVNop9ChIrYpbQ2YmzbxUCrRq008I8hTXCoPp1sLtK0Q
	DaVc81VyZtlLtVIRWfyzgSHGxh8V4DydGZ2Boq
X-Gm-Gg: AY/fxX5NXEYidt7cZsM0p1+8EF57F6J+JsoS2r1FR5A33Yjfw8dEe6ILkOhWlN8KVAi
	4kEp4vxH4L++MfPXft2+k1SFq00uToJvt34EaZJJdPzjRT95gbCg3vXLpyY9tuJigiIUnl8OpHx
	mDmT+1YFfIuqt4GfID5NcMrEHR44c32eoBuKHUMvjPZ8Qy1gGcKo3es7Gp/aeXqm6f3w==
X-Received: by 2002:a05:622a:2610:b0:4f3:4cde:1660 with SMTP id d75a77b69052e-4f4abde3adbmr258768071cf.83.1766528558088;
        Tue, 23 Dec 2025 14:22:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGi4e7XO1ZkNgre5YmuBCNz5q6xa55HJ+SYoWktaQtFe9+AZoVwbSxJGjORZkA1ursbfsabV1xTACHQ+nfdd2s=
X-Received: by 2002:a05:622a:2610:b0:4f3:4cde:1660 with SMTP id
 d75a77b69052e-4f4abde3adbmr258767911cf.83.1766528557702; Tue, 23 Dec 2025
 14:22:37 -0800 (PST)
MIME-Version: 1.0
References: <20251020222410.8235-1-ltao@redhat.com> <20251020222410.8235-9-ltao@redhat.com>
 <87bjkgilxs.fsf@oracle.com> <CAO7dBbVck88aKxrk2sZ5Si_PJH1mvLbjx+92+xEcB9SM8kRcjQ@mail.gmail.com>
 <a3bbfb41-397d-4525-91c7-d3f2703bc708@nec.com>
In-Reply-To: <a3bbfb41-397d-4525-91c7-d3f2703bc708@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 24 Dec 2025 11:22:00 +1300
X-Gm-Features: AQt7F2roYB8XZF4bg48ffcpODE7Stz31CJ6YjaqnIxdwSFBJiVIBVKVaSGsjDps
Message-ID: <CAO7dBbXQq2FxA2JepCTWS0Q0pNzYxv6vQEGXhmEZv4wqXJSD5Q@mail.gmail.com>
Subject: Re: [PATCH v2][makedumpfile 08/14] Implement kernel btf resolving
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FMoHIdnEZHseiBy_UlvmsJoumRuG7Hxw_5RquWq5Wl8_1766528558
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251223_142243_761740_3FA8EC9B 
X-CRM114-Status: GOOD (  45.15  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Kazu,

On Tue, Dec 23, 2025 at 8:38=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
<k-hagio-ab@nec.com> wrote:
>
> On 2025/12/03 9:52, Tao Liu wrote:
> > Hi Stephen,
> >
> > Thanks for your comments!
> >
> > On Wed, Dec 3, 2025 at 11:00=E2=80=AFAM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> >>
> >> Tao Liu <ltao@redhat.com> writes:
> >>> This patch will parse kernel's btf data. The data can be located via
> >>> __start_BTF and __stop_BTF symbols which have been resolved by kallsy=
ms of
> >>> the previous patch.
> >>>
> >>> The btf data is organized as follows: each one of kernel modules, inc=
luding
> >>> vmlinux itself, will have a btf_file struct describing its btf data, =
and
> >>> holding an array of struct name_entry. By given the btf type id, we c=
an resolve
> >>> its name_entry fast by array index. In addition, name_entry can also =
be
> >>> organized in hash table. So given a type name, we can also resolve it=
s
> >>> name_entry in a fast speed. In other words, both btf type id and btf
> >>> type name can we get it resolved fast. Once we get the name_entry str=
ucture of
> >>> the btf type, we can resolve its member/size etc easily.
> >>>
> >>> Since all name_entry array starting from index 0, which cannot identi=
fy a btf
> >>> type globally. So a uniq id is used, its value is accumulated by the =
location
> >>> of the btf_file within btf_file_array and total quantity of btf types=
 within
> >>> each btf_file.
> >>>
> >>> Signed-off-by: Tao Liu <ltao@redhat.com>
> >>
> >> Hi Tao,
> >>
> >> I haven't read this patch in detail, but I wanted to ask if you had an=
y
> >> particular reason to avoid using libbpf for parsing the BTF?
> >
> > Actually I manually parse BTF data due to the following concerns:
> >
> > 1) Learn BTF data structure by manually parsing. I haven't worked on
> > BTF previously, and I prefer the way of doing things from scratch in
> > order to learn as fast and as deeply. I didn't do any project prior to
> > this one relating to BTF. So I started manual parsing and kept it in
> > the  patchset.
> >
> > 2) Let everything be under control. Before actually working on this, I
> > know that the BTF/kallsyms parsing will be running in 2nd kernel, so
> > it should have a good balance of 1) as fast, 2) less memory
> > consumption. So I created 2 ways for BTF resolving: 1) Given id of btf
> > type, resolve it by array index(some meta data of BTF types are
> > organized in array, so easy to resolve the corresponding BTF type by
> > the meta data); 2) Given name of btf type, resolve it by hash table.
> > Like I said, only necessary data is stored within memory, others are
> > left as disk files to read when needed. I'm not saying I did a better
> > job than libbpf, my approach is more white-box to me, and easy to
> > improve.
> >
> > 3) I'm happy to improve the patchset, if libbpf is better in 2nd
> > kernel + eppic case, I can replace all those into libbpf APIs.
> >
> >>
> >> For my implementation of BTF parsing for drgn I was not aware of it, s=
o
> >> I did the parsing entirely manually, similar to this. But for my recen=
t
> >> attempt[1] at adding BTF support to makedumpfile (unaware of this patc=
h), I
> >> used libbpf and found that it did reduce the amount of required code b=
y
> >> a lot. These are specific functions I found useful:
> >>
> >> - btf__new() -> returns a "struct btf *" for use with the library
> >> - btf__type_by_id() -> returns the "struct btf_type *". Then, the
> >>    linux/btf.h header provides several inline functions to work with i=
t:
> >>    - btf_members(), btf_vlen()
> >>    - btf_member_bit_offset()
> >> - btf__pointer_size()
> >> - btf__name_by_offset() -> returns the name for a string offset
> >> - btf__find_by_name() & btf__find_by_name_kind() -> looks up a type by
> >>    name. Note that this does a linear search, so your hash table appro=
ach
> >>    is better for random lookups.
> >> - btf__resolve_size()
> >>
> >> So with libbpf, the only thing you'd really need to implement is
> >> resolving member offsets (supporting anonyomus structs, recursively,
> >> etc), and a hash table for string lookups, if you feel it's necessary.
> >> For module BTF, btf__new_split() is available as well.
> >
> > Thanks for providing the info, I can give it a try and do a
> > performance/memory consumption measurement. In the meantime, I'm keen
>
> Thank you for the information and thoughts.
>
> Considering its maintenance, I think it would be better to use the
> library if possible.  It's hard for others than the auther to maintain
> scratch code and follow the changes of BTF.  If you don't want to use
> the library, please give us performance/memory consumption data or
> something to convince that the library cannot be used.
>

Thanks for your comments. I will give the library a try and see which
approach has better performance/memory balance in v3.

Thanks,
Tao Liu


> Thanks,
> Kazu
>
> > for any suggestions on the whole BTF/kallsyms + eppic approach for
> > makedumpfile customization. I guess there are cases other than GPU mm
> > filtering which are demanding for extending the current page-flag
> > filtering of makedumpfile.
> >
> > Thanks,
> > Tao Liu
> >
> >>
> >> Thanks,
> >> Stephen
> >>
> >> [1]: https://github.com/brenns10/makedumpfile/commit/98129399a3a10ae72=
408bc4aaec2485f7d220626#diff-e1e6bd59ae956df7d2d42ad3580bd3c04da533f1b90827=
a04e2cc27bbf24b2a7
> >>


