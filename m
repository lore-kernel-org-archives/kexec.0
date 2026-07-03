Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C345C43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iszMYG8/GDwOkWSLEKylfXpVUW/SGclSH7eygKWPKWU=; b=x+6BSBUJGkkEVTOtrqiR1IWMJM
	LyDWfpdh5bTXqqFR+x3tFVzCHdH8kMUMIsakOCefHHOHnniD6DY+G/cK8xzCl26uN/m7hnRN6FL+Y
	1CxLojHSUQ9eW4u3ygjEhD7UnqksqnhJe5BwfoDk5XOmQvShaNDtzifmDfhQwO28B/ulMbBHs7S3L
	rX873E6EUBvtd14XdJ3ibIbWs8Epx+pKQf/sG3OSrkUrRAk1ZCxUcKXgNt1/cKOkziF4WcCOcoz2S
	df/E6TB9mPQjqS3gea1J2Vlzg14OFV0fJTcHNcY7G7J1GxFMtDweVOIPjLEZuz3ztQZLjo7XeErWv
	IyJ9Xg+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wffMx-00000007LJa-2QIw;
	Fri, 03 Jul 2026 14:59:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wffMw-00000007LJL-1E7n;
	Fri, 03 Jul 2026 14:59:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 63C6C60051;
	Fri,  3 Jul 2026 14:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D9A1F000E9;
	Fri,  3 Jul 2026 14:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783090793;
	bh=iszMYG8/GDwOkWSLEKylfXpVUW/SGclSH7eygKWPKWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=A42/s2/bFtKZ/AeyCtaD8M9riPQcpeAsT9Vo43MfiHhG9F1WIggDSFAJtzJAhb3tw
	 Kt4BoIupfmnqE+pDq0X3gliBgR0dXKNsjzgNQ0+tlHw7iS5oEdPvtcclnRGCGWN0/z
	 PDCB0OGy/uIIJ2o5wLDopD4zn5t0Lj7vDyvcqDwaY9p1I2nfrgmFcPgBFOUr50Tjz2
	 w4j6hBfSEoSmi+Wjcl+uDsONz/6TmdHORS4hA6hbG74zd/ckVMwUIrk8a8WjHdtw98
	 s45DWSJPWyzYbiF8YGfAIrZcTHo2Rw6iEDbdtbQ8Y9YBFviXKver4LJunF9elKaCWc
	 pa2Om15Jdy65g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Tao Liu <ltao@redhat.com>,  linux-riscv@lists.infradead.org,
  kexec@lists.infradead.org,  linux-integrity@vger.kernel.org,  Albert Ou
 <aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Paul Walmsley <pjw@kernel.org>,
  kernel-janitors@vger.kernel.org,  LKML <linux-kernel@vger.kernel.org>,
  Baoquan He <bhe@redhat.com>,  Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,  Eric Snowberg <eric.snowberg@oracle.com>,
  Jarkko Sakkinen <jarkko@kernel.org>,  Mimi Zohar <zohar@linux.ibm.com>,
  Nutty Liu <nutty.liu@hotmail.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v4] riscv: Prevent NULL pointer dereference in
 machine_kexec_prepare
In-Reply-To: <5df82d42-89cd-4e39-95a9-a0f164c0ac58@web.de> (Markus Elfring's
	message of "Fri, 3 Jul 2026 16:38:09 +0200")
References: <20260703111530.91285-2-ltao@redhat.com>
	<5df82d42-89cd-4e39-95a9-a0f164c0ac58@web.de>
Date: Fri, 03 Jul 2026 16:59:48 +0200
Message-ID: <2vxzqzlkf7a3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jul 03 2026, Markus Elfring wrote:

>> A NULL pointer dereference issue is noticed in riscv's machine_kexec_pre=
pare(),
>> where image->segment[i].buf might be NULL and copied unchecked.
> =E2=80=A6
>
> Would it be helpful to append parentheses to a function name also in the =
summary phrase?
>
> Why was such a hint not be taken into account from a previous suggestion?

Oh come on, this is a really really minor nitpick. The fact that
machine_kexec_prepare is a function is fairly obvious when reading the
patch. In fact, the first sentence of the commit message uses the
parentheses.

So yes, it would have been nice to have them in the subject. But no,
this is not at all worth anyone's time to fix. Certainly not at all
worth a v5.

Please, let's not nitpick our contributors into giving up.

--=20
Regards,
Pratyush Yadav

