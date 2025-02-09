Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51D6C021A1
	for <kexec@archiver.kernel.org>; Sun,  9 Feb 2025 08:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j31g1VoN7O4XuCmDiX3R+x/Ync3MiakZ5YN14frwoaw=; b=bhhcHruq/7kY1jXlXaM7wY2ERm
	U6GNzv/IKyjEk105/FRq6GOeKaHWy39LpFxktSU17EaPsz8UskGbcX5qqpv52QqNgD95S7EAQAA8i
	YPMhUu32Iscg0c89TGHRYAThuvk85nqUlwBqATbLN0vaTZ+XQgjAd7/kh4PT70jISKjrkn33kxJQD
	7gMJR1iekxAeZycJdjd5GWZ7kViebX+/A25EpGTSX9EvctYPemu6M3wOfLyxIjCODBpBWNmhVszzv
	Jwy/11QTVZ0zsiwW0IOo8FJ8oD6QK6vrHjf484RjocmcTCKdLR778pfDfSanuG+qe+A96Rsv7JnHF
	TrH55lvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1th2Hw-0000000EJXb-2TdF;
	Sun, 09 Feb 2025 08:03:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgxg7-0000000Dwyr-3K0f
	for kexec@lists.infradead.org;
	Sun, 09 Feb 2025 03:08:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739070494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j31g1VoN7O4XuCmDiX3R+x/Ync3MiakZ5YN14frwoaw=;
	b=AYv6noQO8jAZ4JAxcYIjX9TbwGDzUHg4SLFhgZx1wCzjktDLoxe+GIFRQ1K4n0Ql39o4fd
	TMWy+C9+ssZPanATfaM4XoawgeGV/3++l1ybaZ1DN11pHhnSKKEdkx7xWw7hrD4ro63o/b
	F/jOFWt1iwYMhuX4dxVYJiUEmnidv3M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527--0UWXAPWP4aY9sz5uQfGng-1; Sat,
 08 Feb 2025 22:08:10 -0500
X-MC-Unique: -0UWXAPWP4aY9sz5uQfGng-1
X-Mimecast-MFC-AGG-ID: -0UWXAPWP4aY9sz5uQfGng
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC58C1800360;
	Sun,  9 Feb 2025 03:08:03 +0000 (UTC)
Received: from localhost (unknown [10.72.112.28])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48D321800265;
	Sun,  9 Feb 2025 03:08:00 +0000 (UTC)
Date: Sun, 9 Feb 2025 11:07:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	Alexander Graf <graf@amazon.com>, Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	changyuanl@google.com
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
Message-ID: <Z6gcCTBTceixz7yq@MiWiFi-R3L-srv>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206162939.a1f86fb835f1eeb7ed73ff1c@linux-foundation.org>
 <CA+CK2bD6204AKWGOgzLMiMsnVZ=tk+DGc+VWgi3RVt2byaLJJA@mail.gmail.com>
 <Z6a1kxR2GlQoepgI@MiWiFi-R3L-srv>
 <CA+CK2bDgP2DfsfVAhQhFhBiNJFUS1n17oX9KgC1JFXAk76j01Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDgP2DfsfVAhQhFhBiNJFUS1n17oX9KgC1JFXAk76j01Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250208_190815_976653_FBDB422D 
X-CRM114-Status: GOOD (  35.94  )
X-Mailman-Approved-At: Sun, 09 Feb 2025 00:03:34 -0800
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

On 02/08/25 at 07:23pm, Pasha Tatashin wrote:
> On Fri, Feb 7, 2025 at 8:38 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 02/06/25 at 08:28pm, Pasha Tatashin wrote:
> > > On Thu, Feb 6, 2025 at 7:29 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Thu,  6 Feb 2025 15:27:40 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > > This a next version of Alex's "kexec: Allow preservation of ftrace buffers"
> > > > > series (https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com),
> > > > > just to make things simpler instead of ftrace we decided to preserve
> > > > > "reserve_mem" regions.
> > > > >
> > > > > The patches are also available in git:
> > > > > https://git.kernel.org/rppt/h/kho/v4
> > > > >
> > > > >
> > > > > Kexec today considers itself purely a boot loader: When we enter the new
> > > > > kernel, any state the previous kernel left behind is irrelevant and the
> > > > > new kernel reinitializes the system.
> > > >
> > > > I tossed this into mm.git for some testing and exposure.
> > > >
> > > > What merge path are you anticipating?
> > > >
> > > > Review activity seems pretty thin thus far?
> > >
> > > KHO is going to be discussed at the upcoming lsfmm, we are also
> > > planning to send v5 of this patch series (discussed with Mike
> > > Rapoport) in a couple of weeks. It will include enhancements needed
> > > for the hypervisor live update scenario:
> >
> > So is this V4 still a RFC if v5 will be sent by plan? Should we hold the
> > reviewing until v5? Or this series is a infrustructure building, v5 will
> > add more details as you listed as below. I am a little confused.
> 
> We will modify the existing patches and send as v5 because some
> interfaces are going to be changed*.
> 
> Otherwise, v5 will make KHO a lot more flexible as it will allow to
> use the tree all the time while the system is running instead of only
> once during the activation phase.
> 
> * Changing interfaces  is optional, but decision whether to change
> will be discussed at Hypervisor Live Update on Feb 10th:
> https://lore.kernel.org/all/26a4b7ca-93a6-30e2-923b-f551ced03d62@google.com/


Ah, this is what I would like to know about the difference between v4
and v5. Thanks for the information, and looking forward to seeing the v5
update.

> 
> >
> > >
> > > 1. Allow nodes to be added to the KHO tree at any time
> > > 2. Remove "activate" (I will also send a live update framework that
> > > provides the activate functionality).
> > > 3. Allow serialization during shutdown.
> > > 4. Decouple KHO from kexec_file_load(), as kexec_file_load() should
> > > not be used during live update blackout time.
> > > 5. Enable multithreaded serialization by using hash-table as an
> > > intermediate step before conversion to FDT.
> >
> 


