Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FFAC54E60
	for <kexec@archiver.kernel.org>; Tue, 19 Mar 2024 08:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=72Ex9tPon9DVyKDxIdSmDYKCJLfvseKeNj4XBUFl2CE=; b=THhQ3mmd5Ls0gx
	pg6xLi/qF2kx1lBlO27yvt6ecOH1ZmLt6fiyn+TvjcEH0ctwtpq9Cl+EvKnw6h3Q8RDJtXIL/eToY
	NrbQg/C1QEFDg77XIat1zQ8JpMwYKG1z7SxMMB3GCVQx9NsaPqmWvT55j0PeqPBwtm0sqq7hdFfCQ
	OfAPE5byB+4fEDy7xFJV6CIsZsrRsAxn+XPj7wxxwWIE1a5EOQIPo2bS1OANMsnyskqXzrY9P/UDH
	qhdUfodXXE7+Ew+aug+UUKy+Ap0VAONDsptdW1JqQ9zl2Wu9OnteB69GG2tONdexjFEfu4fNcAUw7
	YCJ/of0ziLtJlA3HEREg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmUje-0000000BsE1-2tSy;
	Tue, 19 Mar 2024 08:22:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmUjc-0000000BsCs-07af
	for kexec@lists.infradead.org;
	Tue, 19 Mar 2024 08:22:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710836530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hkY5wgPoRSp6GpZtRFAnNPA5yYwNz0E8/5HClF7CgWM=;
	b=fufRWw2W15ovYRXhVzV4TU1PWqsjruuvh6NIM/JAwx5ftFQHXa+YS8HiXdBDChHfa1LNXM
	XII6MnkKpZ14LgFjZU7Bp+QFRW58NWxp/XYLGJ9CbY04OO30Ke3ShRbc6YiE2pa0RfYgyU
	qYd5sZhiF29HiXSYCrKLaSYtdQ4vudo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-hPdVZsinNrKJsRaZj2WF9g-1; Tue,
 19 Mar 2024 04:22:05 -0400
X-MC-Unique: hPdVZsinNrKJsRaZj2WF9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A77563C0E442;
	Tue, 19 Mar 2024 08:22:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0093B10F53;
	Tue, 19 Mar 2024 08:22:03 +0000 (UTC)
Date: Tue, 19 Mar 2024 16:21:56 +0800
From: Baoquan He <bhe@redhat.com>
To: "chenhaixiang (A)" <chenhaixiang3@huawei.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	Louhongxiang <louhongxiang@huawei.com>,
	"wangbin (A)" <wangbin224@huawei.com>,
	"Fangchuangchuang(Fcc,Euler)" <fangchuangchuang@huawei.com>
Subject: Re: Question about Address Range Validation in Crash Kernel
 Allocation
Message-ID: <ZflLJA9FGmrRE44x@MiWiFi-R3L-srv>
References: <464d781a34694cb996560fed0558e635@huawei.com>
MIME-Version: 1.0
In-Reply-To: <464d781a34694cb996560fed0558e635@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240319_012212_225172_DC0266A8 
X-CRM114-Status: GOOD (  38.25  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 03/19/24 at 07:24am, chenhaixiang (A) wrote:
> Thank you for your reply!
> The kernel version on my machine is kernel-5.10, and the kexec-tools version is kexec-tools-2.0.27. 
> However, my issue seems to be a bit different. On my machine, I can see the crashkernel memory segment in /proc/iomem. However, for some reason, within the address range allocated for crashkernel, there is also a segment marked as 'Reserved' (I'm not sure who marked it). In this scenario, kexec-tools calculates the CRASH MEMORY RANGES incorrectly.
> ```

crashkernel region can't be reserved again once it's allocated and
reserved in memblock. There must be something wrong with the code. You
can try upstream kernel and kexec-tools to see if it exists too. Since
you are using an old kernel and could be on a distros, we may not be
able to cover it. Sorry about that.

If you want to debug to find out the reason, I can help give suggestions.

> cat /proc/iomem
> 2d4fd058-58ffffff : System RAM
>   49000000-58ffffff : Crash kernel
>     53cbd000-53ccffff : Reserved
> ```
> I'm not sure if the crashkernel memory segment should not include other markings, and if not supported, whether kexec-tools should raise an error.
> Thanks
> Chen Haixiang
> ----------
> On 03/19/24 at 9:38qm, Baoquan He wrote:
> > Hi,
> > 
> > On 03/18/24 at 12:00pm, chenhaixiang (A) wrote:
> > > Dear kexec Community Members,
> > >
> > > I encountered an issue while using kexec-tools on my x86_64 machine.
> > > When there is a segment marked as 'reserved' within the memory range
> > allocated for the crash kernel in /proc/iomem,the output appears as follows:
> > > 2d4fd058-60efefff : System RAM
> > >   2d4fd058-58ffffff : System RAM
> > >     49000000-58ffffff : Crash kernel
> > >       53cbd000-53ccffff : Reserved
> > 
> > What kernel are you using? the version of kernel, and kexec-tools?
> > 
> > If you are testing on the latest mainline kernel, you could meet the issue Dave
> > have met and fixed in below patch:
> > 
> > [PATCH] x86/kexec: do not update E820 kexec table for setup_data
> > https://lore.kernel.org/all/ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.com/
> > T/#u
> > 
> > Thanks
> > Baoquan
> > 
> > >
> > > The crash_memory_range array will encounter incorrect address ranges:
> > > CRASH MEMORY RANGES
> > > 000000002d4fd058-0000000048ffffff (0)
> > > 0000000053cbd000-0000000048ffffff (1)
> > > 0000000059000000-0000000053ccffff (0)
> > >
> > > Read the code, I noticed that the get_crash_memory_ranges() function
> > invokes exclude_region() to handle the splitting of memory regions, but it seems
> > unable to properly handle the scenario described above.
> > > The code logic is as follows:
> > > ...
> > > 	if (start < mend && end > mstart) {
> > > 		if (start != mstart && end != mend) {
> > > 			/* Split memory region */
> > > 			crash_memory_range[i].end = start - 1;
> > > 			temp_region.start = end + 1;
> > > 			temp_region.end = mend;
> > > 			temp_region.type = RANGE_RAM;
> > > 			tidx = i+1;
> > > 		} else if (start != mstart)
> > > 			crash_memory_range[i].end = start - 1;
> > > 		else
> > > 			crash_memory_range[i].start = end + 1;
> > > 	}
> > > ...
> > > If start < mstart < mend < end, resulting in crash_memory_range[i].end
> > becoming less than crash_memory_range[i].start, leading to incorrect address
> > ranges.
> > > I would like to know if this behavior is reasonable and whether it is necessary to
> > validate the address ranges for compliance at the end.
> > >
> > > Thank you for your time and assistance.
> > >
> > > Chen Haixiang
> > >
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> > >
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
