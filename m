Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE301C4829E
	for <kexec@archiver.kernel.org>; Thu, 15 Feb 2024 08:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qbZcmBIAJzzAn92DpFZ/cRexGAqdqZXmse2B8B10T3c=; b=gFvzVYE8xltnXC
	M1SrGXZZ7ABIW4C3Ow525P1ncvjy14UnyXAR1XXdBfIL7ri5plUmbDe7BEKLNp1P9z9ynKm2BQGv8
	Qb+QDGpa79Y/CWbRGMxZOkm3fIAdbrlEWy0WgIhAirVKv4RoK3bHDXkPNIPu72gSDRiF9frxsTLrv
	FaQiD+VaRmpuqcXtB3GIShua9QAvYHHV+WCegZ6rmcTr9jAlMhh8XFFaY7CyAg1v2vUZdn5dfF3Ui
	NLmadjEqjXu33eUl4PKobRtx8O9GZGFbVknotlhWVxU7WZYZ3y1/u0wg14FGJ49oFnJULhcSH2oji
	H4GxLogjsm5yXyR8D8Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raXNj-0000000FOMG-23yi;
	Thu, 15 Feb 2024 08:46:11 +0000
Received: from mail.hiugelin.pl ([162.19.74.36])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raXNf-0000000FOLW-2gS2
	for kexec@lists.infradead.org;
	Thu, 15 Feb 2024 08:46:10 +0000
Received: by mail.hiugelin.pl (Postfix, from userid 1002)
	id A8DCE46727; Thu, 15 Feb 2024 08:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hiugelin.pl; s=mail;
	t=1707986759; bh=/1bhw7TpsyJZxv1Oe9RkW+bvGUrwv+GHS17HVEdrwls=;
	h=Date:From:To:Subject:From;
	b=XYWsUd4U3GFoofFSia82Q+hpfH0mlaWC8B7IsfnwGnZw8OjwcsKbE2mBRhnx9E76D
	 vZK6yT+oIRwGCLVulT/zq+E/Hh3dE3ddlt2gQrjbbaJSrW0qdDuBQCmO5KDtm8Z789
	 kmwePxIp5a60aKoNsaOTdcT9iHqYC+DLW1OsrXWfi0jo9OwoUG+JEYiqM3jHC9MRDz
	 EdA7twlAnHOSvLs39yWK9CBAbSpx4bC2wG0+9+aPfUiORkf5DtQB0CsRPMGZlwzBvY
	 eO9FBX4mNtOWuHtZ64yowg5hjx6pIJNYurdbIggKerHinQE8UahN0mP/0fCYMGb1LY
	 kfS/+i2m4RBGA==
Received: by mail.hiugelin.pl for <kexec@lists.infradead.org>; Thu, 15 Feb 2024 08:45:33 GMT
Message-ID: <20240215074500-0.1.p.1zvf.0.y0wwj6g3nl@hiugelin.pl>
Date: Thu, 15 Feb 2024 08:45:33 GMT
From: "Robert Palacz" <robert.palacz@hiugelin.pl>
To: <kexec@lists.infradead.org>
Subject: Faktoring dla firm
X-Mailer: mail.hiugelin.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240215_004608_432676_B8ADD234 
X-CRM114-Status: UNSURE (   1.37  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

RHppZcWEIGRvYnJ5LAoKb2ZlcnVqZW15IHN6eWJraWUgaSBuYXR5Y2htaWFzdG93ZSByb3p3acSF
emFuaWEgcMWCYXRuaWN6ZSwgcG96d2FsYWrEhWMgcHJ6ZWRzacSZYmlvcmNvbSB1bmlrYcSHIG9w
w7PFum5pZcWEIHcgb3RyenlteXdhbml1IMWbcm9ka8Ozdy4KCkR6acSZa2kgZmFrdG9yaW5nb3dp
IG90cnp5bWFqxIUgUGHFhHN0d28gemFwxYJhdMSZIHphIHN3b2plIHVzxYJ1Z2kgbmF3ZXQgdyBw
cnp5cGFka3UgcHJvYmxlbcOzdyBmaW5hbnNvd3ljaCBLbGllbnTDs3cuCgpOYXN6ZSBwb2RlasWb
Y2llIGplc3QgZWxhc3R5Y3puZSwgYSBuYXN6ZSByb3p3acSFemFuaWEga2HFvGRvcmF6b3dvIGRv
c3Rvc293dWplbXkgZG8gaW5keXdpZHVhbG55Y2ggcG90cnplYiBmaXJteS4KCkN6eSBjaGNpZWxp
YnkgUGHFhHN0d28gcG96bmHEhyBzemN6ZWfDs8WCeSBpIGRvc3TEmXBuZSBvcGNqZSBkbGEgc3dv
amVqIGR6aWHFgmFsbm/Fm2NpPwoKClBvemRyYXdpYW0KUm9iZXJ0IFBhbGFjegoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0
CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9rZXhlYwo=
